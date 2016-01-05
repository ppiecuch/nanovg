#include <qdebug.h>
#include <qfile.h>

// (-1) if file not exists
extern "C" long qFileSize(const char *filename)
{
	long size = -1;
	QFile f(filename);
	if (f.open(QIODevice::ReadOnly)) {
	    size = f.size(); // when file does open.
	   	f.close();
	}
	return size;
}

extern "C" long qReadFile(const char *filename, char *buffer, long maxSize)
{
  QFile file(filename);
  if (!file.open(QIODevice::ReadOnly))
     return 0;
  return file.read(buffer, maxSize);
}
