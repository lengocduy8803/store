# Pin npm packages by running ./bin/importmap

pin "application"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"

