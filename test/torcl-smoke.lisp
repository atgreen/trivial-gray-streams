;;;; Preserve native Gray generic identities; parallel generic functions break
;;;; stream dispatch for clients such as Flexi Streams.
(require :asdf)
(asdf:load-asd (merge-pathnames "../trivial-gray-streams.asd" *load-truename*))
(asdf:load-system :trivial-gray-streams)
#+(or torcl sbcl)
(dolist (name '("STREAM-READ-CHAR" "STREAM-READ-BYTE" "STREAM-WRITE-CHAR"
                "STREAM-UNREAD-CHAR" "STREAM-FINISH-OUTPUT"))
  (assert (eq (find-symbol name :trivial-gray-streams)
              (find-symbol name #+torcl :torcl-gray-streams #+sbcl :sb-gray))))
(assert (subtypep 'trivial-gray-streams:fundamental-character-input-stream
                  #+torcl 'torcl-gray-streams:fundamental-character-input-stream
                  #+sbcl 'sb-gray:fundamental-character-input-stream
                  #-(or torcl sbcl) 'stream))
(format t "GRAY-PORT-OK~%")
