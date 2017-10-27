<?php
/*

   Copyright 2016 Giménez, Christian

   Author: Giménez, Christian

   tools_navbar.php

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
<div data-role="navbar">
    <label>Translate</label>
    <select data-mini="true" data-inline="true" data-native-menu="false" id="strategy_select">
	<option value="todo" selected="true">To-Do</option>
	<option value="crowd">Crowd's Metamodelling</option>
    </select>
    <select data-mini="true" data-inline="true" data-native-menu="false" id="format_select">
	<option value="owllink" selected="true">OWLlink</option>
	<option value="owl">OWL 2</option>
	<option value="html">DL in HTML (Human Readable)</option>
	<option value="rdfxml">RDF in XML</option>
	<option value="rdfturtle">RDF in Turtle</option>
	<option value="rdfmanchester">RDF in Manchester</option>
    </select>
    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="translate_button">Translate</a>

    <label>Go through Metamodel</label>
    <a class="ui-btn ui-icon-plus ui-btn-icon-left ui-corner-all" type="button" id="meta_erd_button">Meta > UML</a>
    <a class="ui-btn ui-icon-plus ui-btn-icon-left ui-corner-all" type="button" id="meta_orm_button">Meta > ORM</a>

    <label>New Entity</label>
    <input data-mini="true" placeholder="ClassName" type="text" id="crearclase_input"/>
    <a class="ui-btn ui-icon-plus ui-btn-icon-left ui-corner-all" type="button" id="eercrearclase_button">New Entity</a>

    <label>Insert OWLlink data</label>
    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="insertowllink_button">Insert OWLlink</a>
    <label>Reset All</label>
    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="resetall_button">Reset All</a>
    <label>Import JSON</label>
    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="importjson_open_dialog">Import JSON</a>
    <label>Export JSON</label>
    <a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all" type="button" id="exportjson_open_dialog">Export JSON</a>
    <hr/>
    <p>Profile</p>
    <div data-role="controlgroup" data-type="horizontal">
	<a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all ui-btn-inline ui-mini" type="button" id="savejson">Save</a>
	<a class="ui-btn ui-icon-edit ui-btn-icon-left ui-corner-all ui-btn-inline ui-mini" type="button" id="savejson">Load</a>
    </div>
</div>
