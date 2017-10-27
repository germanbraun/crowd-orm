<?php
/*

Copyright 2017, Grupo de Investigación en Lenguajes e Inteligencia Artificial (GILIA)

Author: Facultad de Informática, Universidad Nacional del Comahue

isaoptions.php

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


?>

<div class="isaOptions" style="visible:false, z-index:1, position:absolute">
    <input type="hidden" id="relationoptions_classid"  name="classid"  value="<%= classid %>" />
    <a class="ui-btn ui-corner-all ui-icon-arrow-u ui-btn-icon-notext" type="button" id="isa_button">Is A</a>
    <fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
	<input type="checkbox" name="chk-covering" id="chk-covering"/>
	<label for="chk-covering">Covering</label>
	<input type="checkbox" name="chk-disjoint" id="chk-disjoint" />
	<label for="chk-disjoint">Disjoint</label>
    </fieldset>

</div>
