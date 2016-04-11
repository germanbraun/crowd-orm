# server.coffee --
# Copyright (C) 2016 Giménez, Christian

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


remove_xml_spaces = (xml_str) ->
    xml_str = xml_str.trim()
    xml_str = xml_str.replace(/>\s+/,">")
    xml_str = xml_str.replace(/\s+</,"<")
    xml_str = xml_str.replace(/"\s+/, "\" ")
    xml_str = xml_str.replace(/\s+"/, " \"")
    xml_str = xml_str.replace(/'\s+/, "' ")
    xml_str = xml_str.replace(/\s+'/, " '")

alert_func = (status, error) ->    
    console.log(status)
    console.log(error)

QUnit.test( "translate_request test", ( assert ) ->
    expected ='<?xml version="1.0" encoding="UTF-8"?>
<RequestMessage xmlns="http://www.owllink.org/owllink#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.owllink.org/owllink# http://www.owllink.org/owllink-20091116.xsd"><CreateKB kb="http://localhost/kb1"/><Tell kb="http://localhost/kb1"><owl:SubClassOf><owl:Class IRI="Hi World"/><owl:Class abbreviatedIRI="owl:Thing"/></owl:SubClassOf></Tell><IsKBSatisfiable kb="http://localhost/kb1"/><IsClassSatisfiable kb="http://localhost/kb1"><owl:Class IRI="Hi World"/></IsClassSatisfiable></RequestMessage>'
    expected = remove_xml_spaces(expected)
   
    conn = new ServerConnection( alert_func )
    conn.set_urlprefix("../../web-src/")
    
    diag = new Diagrama(null)
    diag.agregar_clase(new Class("Hi World"))

    done = assert.async()    
    conn.request_translation(
        JSON.stringify(diag.to_json()),
        "owllink",
        (data) ->           
            actual = remove_xml_spaces(data)
            assert.equal(actual , expected,
                "Simple class" )
            done()
    )


    # assert.propEqual(actual , expected, "Translation" )
)


QUnit.test( "satisfiable_request test", ( assert ) ->
    expected =
        satisfiable:
            kb: true,
            classes: ["Hi World"]
        unsatisfiable:
            classes:[]
        suggestions:
            links:[],
        reasoner:
            input: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<RequestMessage xmlns=\"http:\/\/www.owllink.org\/owllink#\" xmlns:owl=\"http:\/\/www.w3.org\/2002\/07\/owl#\" xmlns:xsi=\"http:\/\/www.w3.org\/2001\/XMLSchema-instance\" xsi:schemaLocation=\"http:\/\/www.owllink.org\/owllink# http:\/\/www.owllink.org\/owllink-20091116.xsd\"><CreateKB kb=\"http:\/\/localhost\/kb1\"\/><Tell kb=\"http:\/\/localhost\/kb1\"><owl:SubClassOf><owl:Class IRI=\"Hi World\"\/><owl:Class abbreviatedIRI=\"owl:Thing\"\/><\/owl:SubClassOf><\/Tell><IsKBSatisfiable kb=\"http:\/\/localhost\/kb1\"\/><IsClassSatisfiable kb=\"http:\/\/localhost\/kb1\"><owl:Class IRI=\"Hi World\"\/><\/IsClassSatisfiable><\/RequestMessage>",
            output: "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ResponseMessage xmlns=\"http:\/\/www.owllink.org\/owllink#\"                 xmlns:owl=\"http:\/\/www.w3.org\/2002\/07\/owl#\">  <KB kb=\"http:\/\/localhost\/kb1\"\/>  <OK\/>  <BooleanResponse result=\"true\"\/>  <BooleanResponse result=\"true\"\/><\/ResponseMessage>"

    conn = new ServerConnection(alert_func)
    conn.set_urlprefix("../../web-src/")
    
    diag = new Diagrama(null)
    diag.agregar_clase(new Class("Hi World"))

    done = assert.async()    
    conn.request_satisfiable(
        JSON.stringify(diag.to_json()),
        (data) ->           
            actual = JSON.parse(data)
            assert.propEqual(actual , expected,
                "Simple class" )
            done()
    )


    # assert.propEqual(actual , expected, "Translation" )
)

exports = exports ? this
exports.alert_func = alert_func
