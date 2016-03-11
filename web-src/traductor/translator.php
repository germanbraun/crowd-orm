<?php
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   translator.php
   
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
   I translate a JSON formatted diagram into something else depending on the Builder instance given.
   
   1. Give a Strategy translator instance for specifying the algorithm for translating the diagram.
   2. Give a Builder for specifying the output format.
 */
class Translator{
    protected $strategy = null;
    protected $builder = null;

    function __construct($strategy, $builder){
        $this->$strategy = $strategy;
        $this->$builder = $builder;
    }
}
