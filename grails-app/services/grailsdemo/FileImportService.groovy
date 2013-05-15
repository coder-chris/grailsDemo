package grailsdemo

class FileImportService {

	def importCountryFile() {
		
		//TODO: Fix so file is loaded from relative directory
		//http://stackoverflow.com/questions/5935230/how-to-access-files-in-the-project-directory-with-grails
		//http://stackoverflow.com/questions/570713/grails-base-dir-system-property?rq=1
		
		new File("/Users/devtest/git/grailsDemo/web-app/files/Countries.csv").toCsvReader([separatorChar:';']).eachLine { tokens ->
			new Country(name: tokens[0],        //ISO 3166 country name
						iso2digitCode: tokens[1],			//ISO 3166 2 letter character code
						iso3digitCode: tokens[2]).save() //ISO 3166 3 letter character code
		}
    }
	
}
