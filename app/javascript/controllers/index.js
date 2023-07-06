// Import and register all your controllers from the importmap under controllers/*
//import { Application } from "stimulus"
//import Carousel from "stimulus-carousel" 

import { application } from "controllers/application"


// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"


// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)



// app/javascript/controllers/index.js

//const app = Application.start()
//app.register("carousel", Carousel)

eagerLoadControllersFrom("controllers", application)

 