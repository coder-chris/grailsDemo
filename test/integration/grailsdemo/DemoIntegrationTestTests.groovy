package grailsdemo

import static org.junit.Assert.*
import org.junit.*

class DemoIntegrationTestTests {
	def fileImportService

    @Before
    void setUp() {
        // Setup logic here
    }

    @After
    void tearDown() {
        // Tear down logic here
    }

    @Test
    void testCountryFileImport() {
		fileImportService.importCountryFile()
        assertEquals 249, Country.count()
    }
}