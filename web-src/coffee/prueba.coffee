# prueba.coffee --
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


# Prueba exhaustiva, generar cantclases clases.

lst_clases = []
lst_rels = []
startx = 0
starty = 0
# width = 220; height = 100
xmax = startx + 220 * 10 + 50 # Queremos una separación de 5 pixeles 5*10=50
ymax = starty + 100 * 10 + 50 # ^^^ Idem ^^^

prueba = (cantclases) ->
    xpos = startx
    ypos = starty
    anterior = null
    
    for i in [0..cantclases]
        do (i) ->
            xpos += 225
            if (xpos >= xmax)
                xpos = startx
                ypos += 105
            
            clase = new uml.Class(
                position:
                    x: xpos
                    y: ypos                        
                size:
                    width: 220
                    height: 100
                name: 'Clase ' + String(i)
                attrs: css_clase
            );
            
            lst_clases.push(clase)
            
            if (anterior != null)
                rel = new uml.Generalization(
                    source:
                        id: anterior.id
                    target:
                        id: clase.id
                );
                
                lst_rels.push(rel)
                
            anterior = clase
            
        # End for..do
        graph.addCells(lst_clases)
        graph.addCells(lst_rels)

# If exports doesn't exists, use "this".
exports = exports ? this

exports.prueba = prueba
