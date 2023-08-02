# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "slim-select", to: "https://ga.jspm.io/npm:slim-select@2.6.0/dist/slimselect.es.js"

pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.esm.js"
pin "Chart.bundle", to: "Chart.bundle.js"

pin "ahoy", to: "https://ga.jspm.io/npm:ahoy@1.0.1/lib/index.js"
pin "os", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/os.js"
