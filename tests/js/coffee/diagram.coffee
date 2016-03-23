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
    diag = new Diagrama();
    c = new Class("hi world");
    diag.agregar_clase(new Class("Class1"))
    diag.agregar_clase(c)
    diag.agregar_clase(new Class("Class1"))

    # Executing test:
    diag.delete_class(c)
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.get_clases().length
    
    assert.equal(actual , expected, "dia.to_json" )
    
)

QUnit.test("diag.delete_by_name", (assert) ->
    expected = 2

    # preparation   
    diag = new Diagrama();
    c = new Class("hi world");
    diag.agregar_clase(new Class("Class1"))   
    diag.agregar_clase(c);
    diag.agregar_clase(new Class("Class2"))

    # Executing test:
    diag.delete_class_by_name("hi world")
    
    # actual = JSON.stringify(diag.to_json())
    actual = diag.get_clases().length
    
    assert.equal(actual , expected, "dia.to_json" )
    
)

QUnit.test("diag.delete_by_classid", (assert) ->
    expected = 2

    # preparation   
    diag = new Diagrama()
    fact = new UMLFactory()
    graph = new joint.dia.Graph()

    c1 = new Class("Class1")
    c = new Class("hi world")
    c2 = new Class("Class2")
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
    
    assert.equal(actual , expected, "dia.to_json" )
    
)
