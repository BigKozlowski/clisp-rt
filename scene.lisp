(defpackage #:clrt-scene
  (:use #:cl #:clrt-camera #:clrt-objects #:linalg)
  (:export #:scene
           #:add-object
           #:render))

(in-package #:clrt-scene)

(defclass scene ()
  ((camera
    :initarg :camera
    :initform (error ":camera must be specified")
    :type camera
    :reader scene-camera)
   (objects
    :initform '()
    :reader scene-objects)
   (lights
    :initform '()
    :reader scene-objects)))

(defun add-object (scene object)
  (push object (slot-value scene 'objects)))

(defun render (scene width height filename)
  (let* ((image (make-instance 'zpng:png
                               :width width
                               :height height))
         (image-data (zpng:data-array image))
         (delta (* pi (/ (camera-fov (scene-camera scene)) 180.0)))
         (maxx (coerce (tan delta) 'single-float))
         (minx (- maxx))
         (maxy (* maxx (/ (coerce height 'single-float) (coerce width 'single-float))))
         (miny (- maxy))
         (stepx (/ (* 2.0 maxx) (coerce width 'single-float)))
         (stepy (/ (* 2.0 maxy) (coerce height 'single-float))))
    (do ((y 0.0 (+ y 1.0)))
        ((>= y height))
      (do* ((x 0.0 (+ x 1.0))
            (x-coord (+ minx (* x stepx)))
            (y-coord (+ miny (* y stepy)))
            (ray-dir (make-vector 3 :data (make-array 3
                                                      :element-type 'single-float
                                                      :initial-contents (vector x-coord y-coord 1.0)))
                     (make-vector 3 :data (make-array 3
                                                      :element-type 'single-float
                                                      :initial-contents (vector x-coord y-coord 1.0)))))
           ((>= x maxx))
        (setf (aref image-data (truncate y) (truncate x) 2) 255)))
    (zpng:write-png image filename :if-exists :supersede)))

