(in-package #:clrt-objects)

(export 'sphere)

(defclass sphere (object)
  ((radius
    :initarg :radius
    :initform (error ":radius must be specified.")
    :type single-float
    :reader sphere-radius)))

(defmethod intersects ((sphere sphere) (ray ray) &key (lower-bound 0.0) shadow-feeler)
  T)
