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
            name: "hi world",
            attrs: [],
            methods: [],
            position:
                x: 20,
                y: 20
            ]
        links: []

    # expected = JSON.stringify(expected)
        
    diag = new model.uml.UMLDiagram();
    diag.agregar_clase(new model.uml.Class("hi world"))
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.to_json()
    assert.propEqual(actual , expected, "dia.to_json" )
)


QUnit.test( "diag.to_json with links", ( assert ) ->
    expected =
        classes: [
            {name: "Person",
            attrs: [],
            methods: [],
            position:
                x: 20,
                y: 20},
            {name: "Cellphones",
            attrs: [],
            methods: [],
            position:
                x: 20,
                y: 20}
            ]
        links: [{
            classes: ["Person", "Cellphones"],
            multiplicity: ["1..1", "1..*"],
            roles: [null, null],
            name: "role",
            type: "association"}]


    # expected = JSON.stringify(expected)
        
    diag = new model.uml.UMLDiagram()
    person = new model.uml.Class("Person")
    cell = new model.uml.Class("Cellphones")
    diag.add_class(person)
    diag.add_class(cell)
    link = new model.uml.Link([person, cell], "role")
    link.set_mult(["1..1", "1..*"])
    diag.agregar_link(link)
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.to_json()
    assert.propEqual(actual , expected, "dia.to_json" )
)
