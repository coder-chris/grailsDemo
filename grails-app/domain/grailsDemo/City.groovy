package grailsDemo

class City {

	String name
	
    static constraints = {
		name(blank: false, maxSize: 100)
    }
}
