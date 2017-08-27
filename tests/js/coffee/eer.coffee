# eer.coffee --
# Copyright (C) 2017 Giménez, Christian

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


QUnit.test("EERDiagram.to_json", (assert) ->
    expected =
        classes: [
            {name: "PhoneCall"},
            {name: "Phone"}
            ],
        attributes: [
            {name: "date", type: "normal"},
            {name: "location", type: "normal"}
            ]
        links: [
            {name: "PhoneCalldate",
            classes: ["PhoneCall", "date"],
            type: "attribute"},
            {name: "Phonelocation",
            classes: ["Phone", "location"],
            type: "attribute"}
            ]

    diag = model.eer.EERDiagram()

    c1 = new model.eer.Entity("PhoneCall")
    c2 = new model.eer.Entity("Phone")
    diag.add_entity(c1)
    diag.add_entity(c2)
    
    diag.add_attribute(
        new model.eer.LinkAttrToEntity(c1, 'date'))
    diag.add_attribute(
        new model.eer.LinkAttrToEntity(c2, 'location'))

    actual = diag.to_json()

    assert.propEqual(actual, expected, "EERDiagram.to_json")
)
