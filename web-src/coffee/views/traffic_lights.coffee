# traffic_lights.coffee --
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


TrafficLightsView = Backbone.View.extend(
    initialize: () ->
        this.render()

    render: () ->
        template = _.template($("#template_trafficlight").html(), {})
        this.$el.html(template)

    events:
        "click a#traffic_btn" : "check_satisfiable"
        
    check_satisfiable: (event) ->
        gui.gui_instance.check_satisfiable()

    turn_red: () ->
        this.$el.find("#traffic_img").attr(
            "src",
            "imgs/h-traffic-light-red.svg") 
    turn_green: () ->
        this.$el.find("#traffic_img").attr(
            "src",
            "imgs/h-traffic-light-green.svg") 
    turn_yellow: () ->
        this.$el.find("#traffic_img").attr(
            "src",
            "imgs/h-traffic-light-yellow.svg")
    turn_yellow_flashing: () ->
        this.$el.find("#traffic_img").attr(
            "src",
            "imgs/h-traffic-light-red-flashing.svg") 
    turn_red_flashing: () ->
        this.$el.find("#traffic_img").attr(
            "src",
            "imgs/h-traffic-light-red-flashing.svg") 
    turn_all: () ->        
        this.$el.find("#traffic_img").attr(
            "src",
            "imgs/h-traffic-light.svg") 
        
)


exports = exports ? this
exports.TrafficLightsView = TrafficLightsView
