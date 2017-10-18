// Generated by CoffeeScript 1.10.0
var GUIEER, exports,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

GUIEER = (function(superClass) {
  extend(GUIEER, superClass);

  function GUIEER(graph, paper) {
    this.graph = graph;
    this.paper = paper;
    this.urlprefix = "";
    this.diag = new ERDiagram(this.graph);
    this.state = gui.state_inst.selection_state();
    this.crearclase = new CreateClassView({
      el: $("#crearclase1")
    });
    this.editclass = new EditClassView({
      el: $("#editclass1")
    });
    this.classoptions = new ClassOptionsView({
      el: $("#classoptions1")
    });
    this.relationoptions = new RelationOptionsView({
      el: $("#relationoptions1")
    });
    this.isaoptions = new IsaOptionsView({
      el: $("#isaoptions1")
    });
    this.trafficlight = new TrafficLightsView({
      el: $("#trafficlight")
    });
    this.owllinkinsert = new OWLlinkInsertView({
      el: $("#owllink_placer")
    });
    this.errorwidget = new ErrorWidgetView({
      el: $("#errorwidget_placer")
    });
    this.importjsonwidget = new ImportJSONView({
      el: $("#importjsonwidget_placer1")
    });
    this.exportjsonwidget = new ExportJSONView({
      el: $("#exportjson_placer")
    });
    this.serverconn = new ServerConnection(function(jqXHR, status, text) {
      return exports.gui.current_gui.show_error(status + ": " + text, jqXHR.responseText);
    });
    $("#diagram-page").enhanceWithin();
    $("#details-page").enhanceWithin();
    gui.set_current_instance(this);
  }

  GUIEER.prototype.set_urlprefix = function(str) {
    return this.urlprefix = str;
  };

  GUIEER.prototype.on_cell_clicked = function(cellview, event, x, y) {
    return this.state.on_cell_clicked(cellview, event, x, y, this);
  };

  GUIEER.prototype.set_options_classid = function(model_id) {
    this.relationoptions.set_classid(model_id);
    this.classoptions.set_classid(model_id);
    return this.isaoptions.set_classid(model_id);
  };

  GUIEER.prototype.hide_options = function() {
    this.classoptions.hide();
    this.relationoptions.hide();
    this.editclass.hide();
    return this.isaoptions.hide();
  };

  GUIEER.prototype.set_editclass_classid = function(model_id) {
    return this.editclass.set_classid(model_id);
  };

  GUIEER.prototype.add_object_type = function(hash_data) {
    this.hide_toolbar();
    return this.diag.add_entity(hash_data);
  };

  GUIEER.prototype.add_attribute = function(hash_data) {
    this.hide_toolbar();
    return this.diag.add_attribute(hash_data);
  };

  GUIEER.prototype.delete_class = function(class_id) {
    return this.diag.delete_class_by_classid(class_id);
  };

  GUIEER.prototype.edit_class_name = function(class_id, name) {
    this.diag.rename_class(class_id, name);
    return this.diag.update_view(class_id, this.paper);
  };

  GUIEER.prototype.add_relationship = function(class_a_id, class_b_id, name, mult) {
    if (name == null) {
      name = null;
    }
    if (mult == null) {
      mult = null;
    }
    this.diag.add_association(class_a_id, class_b_id, name, mult);
    return this.set_selection_state();
  };

  GUIEER.prototype.add_relationship_attr = function(class_id, attribute_id, name) {
    if (name == null) {
      name = null;
    }
    return this.diag.add_relationship_attr(class_id, attribute_id, name);
  };

  GUIEER.prototype.add_relationship_isa = function(class_id, isa_id, name) {
    return this.diag.add_relationship_isa(class_id, isa_id, name);
  };

  GUIEER.prototype.add_relationship_isa_inverse = function(class_id, isa_id, name) {
    if (name == null) {
      name = null;
    }
    return this.diag.add_relationship_isa_inverse(isa_id, class_id, name);
  };

  GUIEER.prototype.add_subsumption = function(class_parent_id, class_child_id, disjoint, covering) {
    if (disjoint == null) {
      disjoint = false;
    }
    if (covering == null) {
      covering = false;
    }
    this.diag.add_generalization(class_parent_id, class_child_id, disjoint, covering);
    return this.set_selection_state();
  };

  GUIEER.prototype.show_error = function(status, error) {
    $.mobile.loading("hide");
    return this.errorwidget.show(status, error);
  };

  GUIEER.prototype.traffic_light_green = function() {
    return this.trafficlight.turn_green();
  };

  GUIEER.prototype.traffic_light_red = function() {
    return this.trafficlight.turn_red();
  };

  GUIEER.prototype.update_satisfiable = function(data) {
    var obj;
    console.log(data);
    obj = JSON.parse(data);
    this.set_trafficlight(obj);
    $("#reasoner_input").html(obj.reasoner.input);
    $("#reasoner_output").html(obj.reasoner.output);
    $.mobile.loading("hide");
    this.set_unsatisfiable(obj.unsatisfiable.classes);
    return this.set_satisfiable(obj.satisfiable.classes);
  };

  GUIEER.prototype.set_trafficlight = function(obj) {
    if (obj.satisfiable.kb) {
      if (obj.unsatisfiable.classes.length === 0) {
        return this.trafficlight.turn_green();
      } else {
        return this.trafficlight.turn_yellow();
      }
    } else {
      return this.trafficlight.turn_red();
    }
  };

  GUIEER.prototype.set_unsatisfiable = function(classes_list) {
    return this.diag.set_unsatisfiable(classes_list);
  };

  GUIEER.prototype.set_satisfiable = function(classes_list) {
    return this.diag.set_satisfiable(classes_list);
  };

  GUIEER.prototype.check_satisfiable = function() {
    $.mobile.loading("show", {
      text: "Consulting server...",
      textVisible: true,
      textonly: false
    });
    return this.serverconn.request_satisfiable(this.diag_to_json(), gui.update_satisfiable);
  };

  GUIEER.prototype.update_translation = function(data) {
    var format;
    format = this.crearclase.get_translation_format();
    if (format === "html") {
      $("#html-output").html(data);
      $("#html-output").show();
      $("#owllink_source").hide();
    } else {
      $("#owllink_source").text(data);
      $("#owllink_source").show();
      $("#html-output").hide();
    }
    $.mobile.loading("hide");
    this.change_to_details_page();
    return console.log(data);
  };

  GUIEER.prototype.translate_owllink = function() {
    var format, json;
    format = this.crearclase.get_translation_format();
    $.mobile.loading("show", {
      text: "Consulting server...",
      textVisible: true,
      textonly: false
    });
    json = this.diag_to_json();
    return this.serverconn.request_translation(json, format, gui.update_translation);
  };

  GUIEER.prototype.change_to_details_page = function() {
    return $.mobile.changePage("#details-page", {
      transition: "slide"
    });
  };

  GUIEER.prototype.change_to_diagram_page = function() {
    return $.mobile.changePage("#diagram-page", {
      transition: "slide",
      reverse: true
    });
  };

  GUIEER.prototype.hide_toolbar = function() {
    return $("#tools-panel [data-rel=close]").click();
  };

  GUIEER.prototype.hide_eerdiagram_page = function() {
    return $("#diagram-eer-page").css("display", "none");
  };

  GUIEER.prototype.show_eerdiagram_page = function() {
    return $("#diagram-eer-page").css("display", "block");
  };

  GUIEER.prototype.set_association_state = function(class_id, mult) {
    this.state = gui.state_inst.association_state();
    this.state.set_cellStarter(class_id);
    return this.state.set_cardinality(mult);
  };

  GUIEER.prototype.set_isa_state = function(class_id, disjoint, covering) {
    if (disjoint == null) {
      disjoint = false;
    }
    if (covering == null) {
      covering = false;
    }
    this.state = gui.state_inst.isa_state();
    this.state.set_cellStarter(class_id);
    return this.state.set_constraint(disjoint, covering);
  };

  GUIEER.prototype.set_selection_state = function() {
    return this.state = gui.state_inst.selection_state();
  };

  GUIEER.prototype.show_export_json = function() {
    this.exportjsonwidget.set_jsonstr(this.diag_to_json());
    $(".exportjson_details").collapsible("expand");
    return this.change_to_details_page();
  };

  GUIEER.prototype.refresh_export_json = function() {
    return this.exportjsonwidget.set_jsonstr(this.diag_to_json());
  };

  GUIEER.prototype.show_import_json = function() {
    this.hide_toolbar();
    return this.importjsonwidget.show();
  };

  GUIEER.prototype.show_insert_owllink = function() {
    return this.change_to_details_page();
  };

  GUIEER.prototype.set_insert_owllink = function(str) {
    return this.owllinkinsert.set_owllink(str);
  };

  GUIEER.prototype.diag_to_json = function() {
    var json;
    json = this.diag.to_json();
    return JSON.stringify(json);
  };

  GUIEER.prototype.import_jsonstr = function(jsonstr) {
    var json;
    json = JSON.parse(jsonstr);
    this.owllinkinsert.append_owllink("\n" + json.owllink);
    return this.import_json(json);
  };

  GUIEER.prototype.import_json = function(json_obj) {
    return this.diag.import_json(json_obj);
  };

  GUIEER.prototype.reset_all = function() {
    this.diag.reset();
    this.owllinkinsert.set_owllink("");
    return this.hide_toolbar();
  };

  GUIEER.prototype.update_metamodel = function(data) {
    console.log(data);
    $("#owllink_source").text(data);
    $("#owllink_source").show();
    $("#html-output").hide();
    $.mobile.loading("hide");
    return this.change_to_details_page();
  };

  return GUIEER;

})(GUIIMPL);

exports = exports != null ? exports : this;

if (exports.gui === void 0) {
  exports.gui = {};
}

exports.gui.gui_instance = null;

exports.gui.set_current_instance = function(gui_instance) {
  return exports.gui.gui_instance = gui_instance;
};

exports.gui.switch_to_erd = function(gui_instance) {
  gui_instance.aux_gui = gui_instance.current_gui;
  gui_instance.current_gui = gui_instance.prev_gui;
  gui_instance.prev_gui = gui_instance.aux_gui;
  return exports.gui.set_current_instance(gui_instance);
};

exports.gui.update_satisfiable = function(data) {
  return exports.gui.gui_instance.update_satisfiable(data);
};

exports.gui.update_translation = function(data) {
  return exports.gui.gui_instance.update_translation(data);
};

exports.gui.show_error = function(jqXHR, status, text) {
  return exports.gui.gui_instance.show_error(status + ": " + text, jqXHR.responseText);
};

exports = exports != null ? exports : this;

exports.gui.GUIEER = GUIEER;
