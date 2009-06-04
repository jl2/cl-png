;;;; -*- Mode: Lisp; -*-

(in-package #:cl-user)

(eval-when (:load-toplevel :execute)
  (asdf:operate 'asdf:load-op '#:cffi-grovel))

#+cffi-features:darwin
(push #p"/usr/X11/lib/" cffi:*foreign-library-directories*)

#+cffi-features:darwin
(push #p"/opt/local/lib/" cffi:*foreign-library-directories*)

(asdf:defsystem #:png
  :description "Read and write PNG (Portable Network Graphics) files."
  :perform (asdf:load-op :after (op png)
			 (pushnew :png *features*))
  :components ((:file "libpng" :depends-on ("grovel"))
	       (cffi-grovel:grovel-file "grovel"))
  :depends-on (#:cffi #:image))

(defpackage #:png
  (:documentation "Read and write PNG (Portable Network Graphics) files.")
  (:use #:common-lisp #:cffi #:image)
  (:shadow #:make-shareable-byte-vector
	   #+(or allegro clisp) #:with-pointer-to-vector-data)
  (:export
   #:image
   #:8-bit-image
   #:16-bit-image
   #:grayscale-image
   #:rgb-image
   #:argb-image
   #:make-image
   #:copy-image
   #:image-height
   #:image-width
   #:image-channels
   #:image-bit-depth
   #:decode
   #:decode-file
   #:encode
   #:encode-file
   #:decode-bmp
   #:decode-bmp-file
   ))


