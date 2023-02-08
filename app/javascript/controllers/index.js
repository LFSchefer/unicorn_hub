// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ReviewFormController from "./review_form_controller"
application.register("review-form", ReviewFormController)

import SearchUnicornsController from "./search_unicorns_controller"
application.register("search-unicorns", SearchUnicornsController)

import StarRatingController from "./star_rating_controller"
application.register("star-rating", StarRatingController)

import TimerController from "./timer_controller"
application.register("timer", TimerController)
