package grailsdemo

import org.springframework.dao.DataIntegrityViolationException

class CityController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cityInstanceList: City.list(params), cityInstanceTotal: City.count()]
    }

    def create() {
        [cityInstance: new City(params)]
    }

    def save() {
        def cityInstance = new City(params)
        if (!cityInstance.save(flush: true)) {
            render(view: "create", model: [cityInstance: cityInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])
        redirect(action: "show", id: cityInstance.id)
    }

    def show(Long id) {
        def cityInstance = City.get(id)
        if (!cityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), id])
            redirect(action: "list")
            return
        }

        [cityInstance: cityInstance]
    }

    def edit(Long id) {
        def cityInstance = City.get(id)
        if (!cityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), id])
            redirect(action: "list")
            return
        }

        [cityInstance: cityInstance]
    }

    def update(Long id, Long version) {
        def cityInstance = City.get(id)
        if (!cityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cityInstance.version > version) {
                cityInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'city.label', default: 'City')] as Object[],
                          "Another user has updated this City while you were editing")
                render(view: "edit", model: [cityInstance: cityInstance])
                return
            }
        }

        cityInstance.properties = params

        if (!cityInstance.save(flush: true)) {
            render(view: "edit", model: [cityInstance: cityInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])
        redirect(action: "show", id: cityInstance.id)
    }

    def delete(Long id) {
        def cityInstance = City.get(id)
        if (!cityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), id])
            redirect(action: "list")
            return
        }

        try {
            cityInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'city.label', default: 'City'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'city.label', default: 'City'), id])
            redirect(action: "show", id: id)
        }
    }
}
