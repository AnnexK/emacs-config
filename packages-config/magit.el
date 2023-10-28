(require 'straight)

(straight-override-recipe
 `(magit
   :build (:not compile)))

(req-package magit
  :require forge sqlite3)
