Grails Demo: Countries and Cities
=================================

This project was started in order to give an overview and demo of Groovy and Grails. It is intended to be a minimum Grails project which demonstrates some of the key features of Grails. This project can be used as a basis for further extensions so that it is possible to test out and learn further features of Groovy and Grails.

Backend Concepts
* Domain Classes
* Relationships between domain classes
* Default scaffolding templates and constraints 
* Use of plugins and buildconfig 
* Importing data from a file
* Services
* Dynamic Finders

Frontend Concepts
* Templates and GSPs
* example form submission
* AJAX submission

Development
* Example test
* Direct access to the database

Countries and Cities is a small web application which offers the following functionality:
* Ability to store information about countries (including their ISO codes, e.g. United Kingdom = GB) 
* Ability to store information about which cities and which country they are in
* Ability to view and update this information through the website
* Import a complete list of ISO country codes from a file into the database
* Get a count of all the entries in the database
* Complete a lookup to find the country name for a 2 digit ISO code
* 


#Groovy/Grails Campus Interactive Coding Session

The following instructions explain how to create this project step by step:

#Requirements

* Grails 2.4.2


#Starting with a Vagrant Environment

Here is how to download a standard environment...

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

Then run...

    bash
    $ git clone https://github.com/janmey/grails-vagrant.git
    $ cd grails-vagrant
    $ vagrant up
    $ vagrant ssh


You should then have the following versions of software installed:

    java version "1.7.0_65"
    Java(TM) SE Runtime Environment (build 1.7.0_65-b17)
    Java HotSpot(TM) Client VM (build 24.65-b04, mixed mode)
    Running GVM server 1.3.13 on vertx 1.3.1.final
    ==> default: Downloading: groovy 2.3.4
    grails 2.4.2 

#Time to start coding....

    $ grails create-app grailsDemo
    $ cd grailsDemo
    $ grails

edit grails-app/conf/BuildConfig.groovy add line:
    
    grails.server.port.http = 8010
   
Start the server...

    $ run-app

Check it's working by visiting [http://localhost:8010/grailsDemo/]()

then...

    $ stop-app
    $ create-domain-class grailsDemo.City

add the following text to the class grails-app/domain/grailsDemo/City.groovy

    String name
    static belongsTo  = [country: Country]
    static constraints = {
        name(blank: false, maxSize: 100)
    }

$ create-domain-class grailsDemo.Country

add the following text to the class rails-app/domain/grailsDemo/Country.groovy

	String name
	static hasMany = [cities: City]
 	String iso2digitCode
 	String iso3digitCode
 	
     static constraints = {
 		name(blank: false, maxSize: 100)
 		iso2digitCode(blank: false, maxSize:2)
 		iso3digitCode(blank: false, maxSize:3)
 	}


#Generate code via the Grails scaffolding...

    $ generate-all grailsDemo.Country
    $ generate-all grailsDemo.City 
    $ run-app

add the following method to the classrails-app/domain/grailsDemo/Country.groovy 

    String toString(){
         name  + " (" + id + ")"
    }


add the following method to the class grails-app/domain/grailsDemo/City.groovy after the line 'String name'

    String toString(){
        name + " (" + id + ")"
    }

NOTE: there's no need to restart the server here. The changes are available directly

    $ create-service grailsDemo.FileImportService 

and add the following:

    class FileImportService {
	def grailsApplication

	def importCountryFile() {

	 		def absolutePath = grailsApplication.mainContext.servletContext.getRealPath('files')
	 		new File(absolutePath+"/Countries.csv").toCsvReader([separatorChar:';']).eachLine { tokens ->
	 			new Country(name: tokens[0],        //ISO 3166 country name
	 						iso2digitCode: tokens[1],			//ISO 3166 2 letter character code
	 						iso3digitCode: tokens[2]).save() //ISO 3166 3 letter character cod
	 		}
	}
	}


grails-app/conf/BuildConfig.groovy
add line (at line 64 as part of the compile time dependencies)

    compile ":csv:0.3.1"

in file grails-app/controllers/grailsdemo/CountryController.groovy add this as the 1st line in class...

    def fileImportService

then add this method

    def initialImport(){
        fileImportService.importCountryFile()
        redirect(action: "index")
     }

create the directory grails-app/files/
and copy the [https://github.com/coder-chris/grailsDemo/blob/master/Countries.csv](Countries.csv) file in to the directory


#If there are problems then (This forces Grails to pull in the CSV library)

    $ stop-app
    $ exit
    $ grails compile 
    $ grails clean-all
    $ grails
    $ start-app
[http://stackoverflow.com/questions/21838403/grails-2-3-5-generate-all-doesnt-exist-but-its-in-the-documentation]()


[http://localhost:8010/grailsDemo/country/initialImport]()


Add button to import countries from homepage
grails-app/views/index.gsp (Just before the closing body tag)

           <div id="importData" role="navigation">
               <h2>Import Data</h2>
               <ul>
                   <g:form controller="country">
                       <g:actionSubmit value="Import Countries" action="initialImport" />
                   </g:form>
           
               </ul>
           </div>


Add First AJAX example: Country Count

grails-app/controllers/grailsdemo/CountryController.groovy

    def countryCount(){
           println "There are " + Country.count() + " countries."
           render "There are " + Country.count() + " countries." 
      }

Add the following in under the title tag in grails-app/views/index.gsp

    <g:javascript library="jquery"/>

And then just before the closing body tag...

			<div id="ajaxExample" role="navigation">
				<h2>Ajax Example</h2>
				<ul>
					<div id="updateMe">This div will be dynamically updated</div>
					
				
					<g:formRemote name="myForm" 
					              update="updateMe"
					              url="[controller: 'country', action: 'countryCount']">
		    			<input type="submit" value="Count Countries" />
					</g:formRemote>
				</ul>
			</div>

Add AJAX example 2: CountryCodeLookup

 In file grails-app/controllers/grailsdemo/CountryController.groovy
       
    def countryLookup(){
            def countryInstance = Country.findByIso2digitCode(params.code)
            render (template: "countryLookup", model: [countryInstance: countryInstance])
       }

Create the file grails-app/views/country/_countryLookup.gsp

    <div>
                  The Country with code=${countryInstance?.iso2digitCode} is ${countryInstance?.name}      
    </div>


And then just before the closing body tag in grails-app/views/index.gsp


			<div id="ajaxExample2" role="navigation">
				<h2>Ajax Example2</h2>
				<ul>
					<div id="updateMe2">This div will be dynamically updated</div>
					
				
					<g:formRemote name="myForm" 
					              update="updateMe2"
					              url="[controller: 'country', action: 'countryLookup',
					                    params: [param1: 'extraInfo1', param2: 'extraInfo2']]">
					    Enter 2 digit ISO code, eg GB: <input name="code" type="text" />
		    			<input type="submit" value="Find Country" />
					</g:formRemote>
				</ul>
			</div>



