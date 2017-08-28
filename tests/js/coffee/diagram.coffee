# diagram.coffee --
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


QUnit.test("diag.delete_class", (assert) ->
    expected = 2

    # preparation   
    diag = new model.uml.UMLDiagram();
    c = new model.uml.Class("hi world");
    diag.agregar_clase(new model.uml.Class("Class1"))
    diag.agregar_clase(c)
    diag.agregar_clase(new model.uml.Class("Class1"))

    # Executing test:
    diag.delete_class(c)
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.get_clases().length
    
    assert.equal(actual , expected, "Passed!" )
    
)

QUnit.test("diag.delete_by_name", (assert) ->
    expected = 2

    # preparation   
    diag = new model.uml.UMLDiagram();
    c = new model.uml.Class("hi world");
    diag.agregar_clase(new model.uml.Class("Class1"))   
    diag.agregar_clase(c);
    diag.agregar_clase(new model.uml.Class("Class2"))

    # Executing test:
    diag.delete_class_by_name("hi world")
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.get_clases().length
    
    assert.equal(actual , expected, "Passed!" )
    
)

QUnit.test("diag.delete_by_classid", (assert) ->
    expected = 2

    # preparation   
    diag = new model.uml.UMLDiagram()
    fact = new model.uml.UMLFactory()
    graph = new joint.dia.Graph()

    c1 = new model.uml.Class("Class1")
    c = new model.uml.Class("hi world")
    c2 = new model.uml.Class("Class2")
    # we need to create the classid using the factory object 
    c1.create_joint(fact) 
    c.create_joint(fact)
    c2.create_joint(fact)
    classid = c.get_classid()    
    diag.agregar_clase(c1)
    diag.agregar_clase(c)
    diag.agregar_clase(c2)

    # Executing test:
    diag.delete_class_by_classid(classid)
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.get_clases().length
    
    assert.equal(actual , expected, "Passed!" )
    
)

QUnit.test("Class.same_elts", (assert) ->
    c1 = new model.uml.Class("Person")
    c2 = new model.uml.Class("Person")
    c3 = new model.uml.Class("Person2")
    c4 = new model.uml.Class("Person", ["Attr1", "Attr2"], ["Methods1", "Methods2"])
    c5 = new model.uml.Class("Person", ["Attr1", "Attr2"], ["Methods1", "Methods2"])
    c6 = new model.uml.Class("Person", ["Attr1", "Attr2"], ["Methods1", "Methods2", "Methods3"])
    
    assert.ok(c1.same_elts(c2))
    assert.ok(c4.same_elts(c5))
    assert.notOk(c1.same_elts(c3))
    assert.notOk(c2.same_elts(c3))
    assert.notOk(c4.same_elts(c6))
    assert.notOk(c5.same_elts(c6))
)

QUnit.test("Link.same_elts", (assert) ->
    c1 = new model.uml.Class("Person")
    c2 = new model.uml.Class("Person")
    c3 = new model.uml.Class("Person2")
    c4 = new model.uml.Class("Person", ["Attr1", "Attr2"], ["Methods1", "Methods2"])
    c5 = new model.uml.Class("Person", ["Attr1", "Attr2"], ["Methods1", "Methods2"])
    c6 = new model.uml.Class("Person", ["Attr1", "Attr2"], ["Methods1", "Methods2", "Methods3"])

    l1 = new model.uml.Link([c1, c3], "link")
    l2 = new model.uml.Link([c1, c3], "link")
    l3 = new model.uml.Link([c2, c3], "link")
    l4 = new model.uml.Link([c1, c3], "link2")
    l5 = new model.uml.Link([c4, c3], "link")
    
    assert.ok(l1.same_elts(l2), "Same classes")
    # c2 class is the same as c1 so l3 is the same as l2
    assert.ok(l2.same_elts(l3), "Same classes (but two constructed)") 
    assert.notOk(l1.same_elts(l4), "Different names")
    assert.notOk(l1.same_elts(l5), "Different classes")

)


QUnit.test("UMLDiagram.same_elts", (assert) ->
    diag1 = new model.uml.UMLDiagram()
    c1 = new model.uml.Class("Person")
    c2 = new model.uml.Class("Cellphones")
    diag1.add_class(c1)
    diag1.add_class(c2)
    link = new model.uml.Link([c1, c2], "role")
    link.set_mult(["1..1", "1..*"])
    diag1.agregar_link(link)

    diag2 = new model.uml.UMLDiagram()
    c1 = new model.uml.Class("Person")
    c2 = new model.uml.Class("Cellphones")
    diag2.add_class(c1)
    diag2.add_class(c2)
    link = new model.uml.Link([c1, c2], "role")
    link.set_mult(["1..1", "1..*"])
    diag2.agregar_link(link)

    diag3 = new model.uml.UMLDiagram()
    c1 = new model.uml.Class("Person3") # Different name.
    c2 = new model.uml.Class("Cellphones")
    diag3.add_class(c1)
    diag3.add_class(c2)
    link = new model.uml.Link([c1, c2], "role")
    link.set_mult(["1..1", "1..*"])
    diag3.agregar_link(link)

    assert.ok(diag1.same_elts(diag2))
    assert.notOk(diag1.same_elts(diag3))
    # Cannot be the same for the ID.
    assert.notEqual(diag1, diag2)
)

QUnit.test("UMLDiagram.import_json", (assert) ->
    expected = new model.uml.UMLDiagram()
    c1 = new model.uml.Class("Person")
    c2 = new model.uml.Class("Cellphones")
    expected.add_class(c1)
    expected.add_class(c2)
    link = new model.uml.Link([c1, c2], "role")
    link.set_mult(["1..1", "1..*"])
    expected.agregar_link(link)

    json =
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

    actual = new model.uml.UMLDiagram()
    actual.import_json(json)
    
    assert.equal(actual, expected, "UMLDiagram.import_json")
)
