
local action = _ACTION or ""
<<<<<<< HEAD
local glfwInc = "$(HOME)/Private/Projekty/_applicationSupport/GLFW/3.0.4/include"
local glfwLib = "$(HOME)/Private/Projekty/_applicationSupport/GLFW/3.0.4/target-osx/src"
=======
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

solution "nanovg"
	location ( "build" )
	configurations { "Debug", "Release" }
	platforms {"native", "x64", "x32"}
<<<<<<< HEAD
	
=======

>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
   	project "nanovg"
		language "C"
		kind "StaticLib"
		includedirs { "src" }
		files { "src/*.c" }
		targetdir("build")
		defines { "_CRT_SECURE_NO_WARNINGS" } --,"FONS_USE_FREETYPE" } Uncomment to compile with FreeType support
<<<<<<< HEAD
		
=======

>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_gl2"

		kind "ConsoleApp"
		language "C"
		files { "example/example_gl2.c", "example/demo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }
			 defines { "NANOVG_GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_gl3"
		kind "ConsoleApp"
		language "C"
		files { "example/example_gl3.c", "example/demo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }
			 defines { "NANOVG_GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_gl2_msaa"
		kind "ConsoleApp"
		language "C"
		defines { "DEMO_MSAA" }
		files { "example/example_gl2.c", "example/demo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }
			 defines { "NANOVG_GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_gl3_msaa"
		kind "ConsoleApp"
		language "C"
		defines { "DEMO_MSAA" }
		files { "example/example_gl3.c", "example/demo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }
			 defines { "NANOVG_GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_fbo"
		kind "ConsoleApp"
		language "C"
		files { "example/example_fbo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_gles2"
		kind "ConsoleApp"
		language "C"
		files { "example/example_gles2.c", "example/demo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}

	project "example_gles3"
		kind "ConsoleApp"
		language "C"
		files { "example/example_gles3.c", "example/demo.c", "example/perf.c" }
<<<<<<< HEAD
		includedirs { "src", "example", glfwInc }
=======
		includedirs { "src", "example" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f
		targetdir("build")
		links { "nanovg" }

		configuration { "linux" }
			 linkoptions { "`pkg-config --libs glfw3`" }
			 links { "GL", "GLU", "m", "GLEW" }

		configuration { "windows" }
			 links { "glfw3", "gdi32", "winmm", "user32", "GLEW", "glu32","opengl32", "kernel32" }
			 defines { "NANOVG_GLEW", "_CRT_SECURE_NO_WARNINGS" }

		configuration { "macosx" }
			links { "glfw3" }
<<<<<<< HEAD
			linkoptions { "-L" .. glfwLib, "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo" }
=======
			linkoptions { "-framework OpenGL", "-framework Cocoa", "-framework IOKit", "-framework CoreVideo", "-framework Carbon" }
>>>>>>> e3033362e5ec53e30340e8410fea3dca2b00a90f

		configuration "Debug"
			defines { "DEBUG" }
			flags { "Symbols", "ExtraWarnings"}

		configuration "Release"
			defines { "NDEBUG" }
			flags { "Optimize", "ExtraWarnings"}
