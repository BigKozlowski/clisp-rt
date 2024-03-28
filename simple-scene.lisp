(defpackage #:simple-scene
  (:use :cl :linalg)
  (:export :render))

(in-package #:simple-scene)

(defparameter *cam* (make-instance 'clrt-camera:camera
                                   :pos (make-vector 3 :data #(0.0 0.0 0.0))
                                   :up (make-vector 3 :data #(0.0 1.0 0.0))
                                   :look-at (make-vector 3 :data #(0.0 0.0 100.0))))

(defparameter *scene* (make-instance 'clrt-scene:scene
                                     :camera *cam*))
(defparameter *blue-material* (make-instance 'clrt-material:material
                                             :ambient-color (make-vector 3 :data #(0.0 0.0 0.3))
                                             :ambient-coeff 0.1
                                             :diffuse-color (make-vector 3 :data #(0.0 0.0 0.8))
                                             :diffuse-coeff 0.6
                                             :specular-color (make-vector 3 :data #(1.0 1.0 1.0))
                                             :specular-coeff 0.3
                                             :roughness 50))

(defparameter *cube* (make-instance 'clrt-objects:cube
                                    :center (make-vector 3 :data #(40.0 0.0 80.0))
                                    :width 40.0
                                    :height 40.0
                                    :depth 40.0
                                    :material *blue-material*))

(defparameter *light* (make-instance 'clrt-lights:light
                                     :pos (make-vector 3 :data #(-100.0 100.0 0.0))))

(defun render ()
  (clrt-scene:clear-scene *scene*)
  (clrt-scene:add-object *scene* *cube*)
  (clrt-scene:add-light *scene* *light*)
  (clrt-scene:render *scene* 640 480 "test.png"))
