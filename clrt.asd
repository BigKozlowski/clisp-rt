(in-package :asdf)

(defsystem "clrt"
  :description "raytracer in clisp"
  :depends-on (#:zpng)
  :components
  ((:file "linalg")
   (:file "camera" :depends-on ("linalg"))
   (:file "objects" :depends-on ("linalg" "camera"))
   (:file "scene" :depends-on ("camera" "objects" "linalg"))))
