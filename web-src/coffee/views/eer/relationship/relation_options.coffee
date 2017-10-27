# relation_options.coffee --
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

exports = exports ? this
exports.views = exports.views ? this
exports.views.eer = exports.views.eer ? this
exports.views.eer.relationship = exports.views.eer.relationship ? this


RelationOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_relationoptions").html() )
        this.$el.html(template({classid: @classid}))

    events:
        "click a#eerassociation_button" : "new_relation",
        "click a#eerassoc_class_button" : "new_assoc_class"

    # Retrieve the source role and multiplicity information.
    cardfrom: () ->
        # from = "2..3"
        # console.log from
        from_1 = $('#cardfrom-1').val()
        from_2 = $('#cardfrom-2').val()
        if (from_1 isnt "") and (from_2 isnt "")
           from_aux = from_1.concat ".."
           @from = from_aux.concat from_2
        else if (from_1 == "") and (from_2 isnt "")
          from_1 = "0"
          from_aux = from_1.concat ".."
          @from = from_aux.concat from_2
        else if (from_1 isnt "") and (from_2 == "")
          from_2 = "*"
          from_aux = from_1.concat ".."
          @from = from_aux.concat from_2
        else @from = ""

        @from_role = $('#role-from').val()

    # Retrieve the destination role and multiplicity
    cardto: () ->
        # too = "4..8"
        # console.log too
        too_1 = $('#cardto-1').val()
        too_2 = $('#cardto-2').val()
        if (too_1 isnt "") and (too_2 isnt "")
           too_aux = too_1.concat ".."
           @too = too_aux.concat too_2
        else if (too_1 == "") and (too_2 isnt "")
          too_1 = "0"
          too_aux = too_1.concat ".."
          @too = too_aux.concat too_2
        else if (too_1 isnt "") and (too_2 == "")
          too_2 = "*"
          too_aux = too_1.concat ".."
          @too = too_aux.concat too_2
        else @too = ""

        @to_role = $('#role-to').val()


    # Create a new relation with the information from the role, multiplicity and
    # association name input fields.
    #
    # Callback, used when the user clicks on the association button.
    new_relation: () ->
        this.cardfrom()
        this.cardto()

        mult = []
        mult[0] = @from
        mult[1] = @too
        roles = []
        roles[0] = @from_role
        roles[1] = @to_role
        name = null
        if $("#assoc_name").val() isnt ""
          name = $("#assoc_name").val()
        @hide()
        gui.gui_instance.set_association_state(@classid, mult, roles, name, false)

    # Create a new relation with the information from the role, multiplicity and
    # association name input fields. *Use an association class in the middle.*
    #
    # Callback, used when the user clicks on the create association class button.
    new_assoc_class: (from, too) ->
        this.cardfrom()
        this.cardto()

        mult = []
        mult[0] = @from
        mult[1] = @too
        roles = []
        roles[0] = @from_role
        roles[1] = @to_role
        name = $("#assoc_name").val()
        @hide()
        gui.gui_instance.set_association_state(@classid, mult, roles, name, true)


    # Map the Option value to multiplicity string.
    #
    # @param str {string} The value string.
    # @return {String} A string that represent the multiplicity as in UML.
    map_to_mult : (str) ->
        switch str
            when "zeromany" then "0..*"
            when "onemany" then "1..*"
            when "zeroone" then "0..1"
            when "oneone" then "1..1"


    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y + 50,
            left: viewpos.x + 100,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    get_classid: () ->
        return @classid

    hide: () ->
        this.$el.hide()

    clear: () ->
        $("#left-rel").trigger("reset")
        $("#name-rel").trigger("reset")
        $("#right-rel").trigger("reset")
)




exports.views.eer.relationship.RelationOptionsView = RelationOptionsView
