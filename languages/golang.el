(require 'projectile)

(projectile-register-project-type 'golang-module '("go.mod" "go.sum")
								  :project-file "go.mod"
								  :compile "go build"
								  :test "go test"
								  :test-prefix "test_"
								  :run "go run")
