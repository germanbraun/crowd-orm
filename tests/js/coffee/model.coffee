# model.coffee --
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


QUnit.test( "diag.to_json", ( assert ) ->
    expected =
        classes: [
            name: "hi world"
            ]
        links: []

    # expected = JSON.stringify(expected)
        
    diag = new Diagram();
    diag.agregar_clase(new Class("hi world"))
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.to_json()
    assert.propEqual(actual , expected, "dia.to_json" )
)


QUnit.test( "diag.to_json with links", ( assert ) ->
    expected =
        classes: [
            {name: "Person"},
            {name: "Cellphones"}
            ]
        links: [{
            classes: ["Person", "Cellphones"],
            multiplicity: ["1..1", "1..*"],
            name: "",
            type: "association"}]


    # expected = JSON.stringify(expected)
        
    diag = new Diagram()
    person = new Class("Person")
    cell = new Class("Cellphones")
    diag.agregar_clase(person)
    diag.agregar_clase(cell)
    link = new Link([person, cell])
    diag.agregar_link(link)
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.to_json()
    assert.propEqual(actual , expected, "dia.to_json" )
)
