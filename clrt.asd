(in-package :asdf)

(defsystem "clrt"
  :description "raytracer in clisp"
  :depends-on (#:zpng)
  :components
  ((:file "linalg")
   (:file "camera" :depends-on ("linalg"))
   (:file "objects" :depends-on ("linalg" "camera" "ray"))
   (:file "scene" :depends-on ("camera" "objects" "linalg"))
   (:file "sphere" :depends-on ("objects" "linalg"))
   (:file "ray" :depends-on ("linalg"))
   (:file "cube" :depends-on ("objects" "linalg"))))
