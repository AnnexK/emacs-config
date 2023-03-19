(straight-override-recipe
 `(magit
   :build (:not compile)))

(req-package magit
  :require forge)
