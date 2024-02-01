// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as ActiveStorage from "@rails/activestorage"
import { Turbo, cable } from "@hotwired/turbo-rails"
import * as UJS from "@rails/ujs"

UJS.start()
Turbo.start()
ActiveStorage.start()