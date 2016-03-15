<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   satisfiable.php
   
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

/**
   Return if the given diagram is satisfiable.
 */

require_once("../common/import_functions.php");

load("translator.php", "../translator/");
load("calvanessestrat.php", "../translator/strategies/");
load("owllinkbuilder.php", "../translator/builders/");

load("runner.php", "../reasoner/");
load("racerconnector.php", "../reasoner/");

use Wicom\Translator\Translator;
use Wicom\Translator\Strategies\Calvanesse;
use Wicom\Translator\Builders\OWLlinkBuilder;

use Wicom\Reasoner\Runner;
use Wicom\Reasoner\RacerConnector;

$trans = new Translator(new Calvanesse(), new OWLlinkBuilder());
$owllink_str = $trans->to_owllink($_POST['json']);

$runner = new Runner(new RacerConnector());
$runner->run($owllink_str);
$answer = $runner->get_last_answer();

$answer->to_json();
?>
