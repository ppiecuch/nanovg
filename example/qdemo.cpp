#include <QDebug>
#include <QDirIterator>
#include <QMouseEvent>
#include <QElapsedTimer>
#include <QWaitCondition>
#include <QPainter>
#include <QWindow>
#include <QOpenGLContext>
#include <QOpenGLPaintDevice>
#include <QOpenGLFunctions>
#include <QOpenGLDebugLogger>
#include <QGuiApplication>

#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>
#include <string.h>

#define NANOVG_GL2
#define NANOVG_GL2_IMPLEMENTATION

#include "nanovg.h"
#include "nanovg_gl.h"
#include "demo.h"
#include "perf.h"

class SleepSimulator {
	QMutex localMutex;
	QWaitCondition sleepSimulator;
public:
	SleepSimulator() { localMutex.lock(); }
	void sleep(unsigned long sleepMS) { sleepSimulator.wait(&localMutex, sleepMS); }
	void CancelSleep() { sleepSimulator.wakeAll(); }
};

double qtGetTime() {
	static QElapsedTimer timer;
	if (!timer.isValid())
	timer.start();
	return timer.elapsed() / 1000.;
}

void qtDelay(long ms) {
	SleepSimulator s;
	s.sleep(ms);
}

// Qt Window

class Window : public QWindow, protected QOpenGLFunctions
{
	Q_OBJECT
private:
	bool m_done, m_update_pending, m_resize_pending, m_auto_refresh;
	QOpenGLContext *m_context;
	QOpenGLPaintDevice *m_device;
public:
	QPoint cursorPos;
private:
	DemoData data;
	NVGcontext* vg;
	PerfGraph fps;
    double prevt;
    int blowup, screenshot, premult;
public:
	Window(QWindow *parent = 0) : QWindow(parent)
	, m_update_pending(false)
	, m_resize_pending(false)
	, m_auto_refresh(true)
	, m_context(0)
	, m_device(0)
	, m_done(false)
	, vg(0), prevt(0), blowup(0), screenshot(0), premult(0) {
		setSurfaceType(QWindow::OpenGLSurface);
	}
	~Window() { delete m_device; }
	void setAutoRefresh(bool a) { m_auto_refresh = a; }

	void render(QPainter *painter) {
		Q_UNUSED(painter);

        double mx = cursorPos.x(), my = cursorPos.y(), t, dt;
		const float pxRatio = devicePixelRatio();
		const int winWidth = width(), winHeight = height(), fbWidth = winWidth*pxRatio, fbHeight = winHeight*pxRatio;

		t = qtGetTime();
		dt = t - prevt;
		prevt = t;
		updateGraph(&fps, dt);

		// Update and render
		glViewport(0, 0, fbWidth, fbHeight);
		if (premult)
			glClearColor(0,0,0,0);
		else
			glClearColor(0.3f, 0.3f, 0.32f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);

		nvgBeginFrame(vg, winWidth, winHeight, pxRatio);

		renderDemo(vg, mx,my, winWidth,winHeight, t, blowup, &data);
		renderGraph(vg, 5,5, &fps);

		nvgEndFrame(vg);

		if (screenshot) {
			screenshot = 0;
			saveScreenShot(fbWidth, fbHeight, premult, "dump.png");
		}
    }
	void initialize() {
		QOpenGLDebugLogger *m_logger = new QOpenGLDebugLogger(this);
		connect( m_logger, &QOpenGLDebugLogger::messageLogged, []( QOpenGLDebugMessage message ){
			qWarning() << "[OpenGL]" << message;
		});
		if ( m_logger->initialize() ) {
			m_logger->startLogging( QOpenGLDebugLogger::SynchronousLogging );
			m_logger->enableMessages();
			qDebug() << "QOpenGLDebugLogger initialized.";
		}
		qDebug() << "OpenGL infos with gl functions:";
		qDebug() << "-------------------------------";
		qDebug() << " Renderer:" << (const char*)glGetString(GL_RENDERER);
		qDebug() << " Vendor:" << (const char*)glGetString(GL_VENDOR);
		qDebug() << " OpenGL Version:" << (const char*)glGetString(GL_VERSION);
		qDebug() << " GLSL Version:" << (const char*)glGetString(GL_SHADING_LANGUAGE_VERSION);
		setTitle(QString("Qt %1 - %2 (%3)").arg(QT_VERSION_STR).arg((const char*)glGetString(GL_VERSION)).arg((const char*)glGetString(GL_RENDERER)));

#ifdef DEMO_MSAA
        vg = nvgCreateGL2(NVG_STENCIL_STROKES | NVG_DEBUG);
#else
        vg = nvgCreateGL2(NVG_ANTIALIAS | NVG_STENCIL_STROKES | NVG_DEBUG);
#endif
        if (vg == NULL)
            qWarning() << "Could not init nanovg.";

        if (loadDemoData(vg, &data) == -1)
            qWarning() << "Could not load demo data.";

        prevt = qtGetTime();
	}
	void update() { renderLater(); }
	void render() {
		if (!m_device) m_device = new QOpenGLPaintDevice;
		glViewport(0, 0, width()*devicePixelRatio(), height()*devicePixelRatio());
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
		m_device->setSize(size());
		QPainter painter(m_device);
		render(&painter);
	}
	void mousePressEvent(QMouseEvent *event) {
		cursorPos = QPoint(event->x(), event->y());
		Qt::KeyboardModifiers modifiers = event->modifiers();
		if (event->buttons() & Qt::LeftButton) { }
	}
	void mouseReleaseEvent(QMouseEvent *event) {
		cursorPos = QPoint(event->x(), event->y());
		Qt::KeyboardModifiers modifiers = event->modifiers();
		if (event->button() == Qt::LeftButton) { }
	}
	void mouseMoveEvent(QMouseEvent *event) {
		cursorPos = QPoint(event->x(), event->y());
	}
	void keyPressEvent(QKeyEvent* event) {
		switch(event->key()) {
			case Qt::Key_Escape: close(); break;
			default: event->ignore();
			break;
		}
	}
	void quit() { m_done = true; }
	bool done() const { return m_done; }
protected:
	void closeEvent(QCloseEvent *event) { quit(); }
	bool event(QEvent *event) {
		switch (event->type()) {
			case QEvent::UpdateRequest:
				m_update_pending = false;
				renderNow();
				return true;
			default:
				return QWindow::event(event);
		}
	}
	void exposeEvent(QExposeEvent *event) {
		Q_UNUSED(event);
		if (isExposed()) renderNow();
	}
	void resizeEvent(QResizeEvent *event)
	{
		renderLater();
	}
public slots:
	void renderLater() {
		if (!m_update_pending) {
			m_update_pending = true;
			QCoreApplication::postEvent(this, new QEvent(QEvent::UpdateRequest));
		}
	}
	void renderNow() {
		if (!isExposed()) return;
		bool needsInitialize = false;
		if (!m_context) {
			m_context = new QOpenGLContext(this);
			m_context->setFormat(requestedFormat());
			m_context->create();
			needsInitialize = true;
		}
		m_context->makeCurrent(this);
		if (needsInitialize) {
			initializeOpenGLFunctions();
			initialize();
		}
		render();
		m_context->swapBuffers(this);
		if (m_auto_refresh) renderLater();
	}
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Window w;
    w.resize(1024, 768);
    w.show();
    return app.exec();
}

#include "qdemo.moc"
