// Generated by CoffeeScript 1.10.0
(function() {
  var ORMFactory, exports, orm, ref,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  orm = joint.shapes.orm;

  exports = exports != null ? exports : this;

  exports.model = (ref = exports.model) != null ? ref : {};

  ORMFactory = (function(superClass) {
    extend(ORMFactory, superClass);

    function ORMFactory() {}

    ORMFactory.prototype.create_class = function(class_name, attribs, methods, css_class) {
      var newclass, params;
      if (css_class == null) {
        css_class = null;
      }
      console.log(attribs);
      console.log(methods);
      params = {
        position: {
          x: 20,
          y: 20
        },
        size: {
          width: 220,
          height: 100
        },
        name: class_name,
        attributes: attribs,
        methods: methods,
        attrs: {
          '.uml-class-name-rect': {
            fill: '#ff8450',
            stroke: '#fff'
          },
          '.uml-class-name-text': {
            fill: '#000000'
          }
        }
      };
      if (css_class != null) {
        params.attrs = css_class;
      }
      newclass = new model.Class(params);
      return newclass;
    };

    ORMFactory.prototype.create_association = function(class_a_id, class_b_id, name, css_links, mult, roles) {
      var labels, link, str_labels;
      if (name == null) {
        name = null;
      }
      if (css_links == null) {
        css_links = null;
      }
      if (mult == null) {
        mult = null;
      }
      if (roles == null) {
        roles = null;
      }
      link = new joint.dia.Link({
        source: {
          id: class_a_id
        },
        target: {
          id: class_b_id
        },
        attrs: css_links
      });
      str_labels = [null, null, null];
      if (roles !== null) {
        if (roles[0] !== null) {
          str_labels[0] = roles[0];
        }
        if (roles[1] !== null) {
          str_labels[2] = roles[1];
        }
      }
      if (mult !== null) {
        if (mult[0] !== null) {
          if (str_labels[0] !== null) {
            str_labels[0] += "\n" + mult[0];
          } else {
            str_labels[0] = mult[0];
          }
        }
        if (mult[1] !== null) {
          if (str_labels[2] !== null) {
            str_labels[2] += "\n" + mult[1];
          } else {
            str_labels[2] = mult[1];
          }
        }
      }
      str_labels[1] = name;
      labels = [];
      if (str_labels[1] !== null) {
        labels[1] = {
          position: 0.5,
          attrs: {
            text: {
              text: str_labels[1],
              fill: '#0000ff'
            },
            rect: {
              fill: '#ffffff'
            }
          }
        };
      }
      if (str_labels[0] !== null) {
        labels[0] = {
          position: 0.1,
          attrs: {
            text: {
              text: str_labels[0],
              fill: '#0000ff'
            },
            rect: {
              fill: '#ffffff'
            }
          }
        };
      }
      if (str_labels[2] !== null) {
        labels[2] = {
          position: 0.9,
          attrs: {
            text: {
              text: str_labels[2],
              fill: '#0000ff'
            },
            rect: {
              fill: '#ffffff'
            }
          }
        };
      }
      link.set({
        labels: labels
      });
      return link;
    };

    ORMFactory.prototype.create_generalization = function(class_a_id, class_b_id, css_links, disjoint, covering) {
      var labels, legend, link;
      if (css_links == null) {
        css_links = null;
      }
      if (disjoint == null) {
        disjoint = false;
      }
      if (covering == null) {
        covering = false;
      }
      labels = [];
      link = new joint.shapes.uml.Generalization({
        source: {
          id: class_b_id
        },
        target: {
          id: class_a_id
        },
        attrs: css_links
      });
      if (disjoint || covering) {
        legend = "{";
        if (disjoint) {
          legend = legend + "disjoint";
        }
        if (covering) {
          if (legend !== "") {
            legend = legend + ",";
          }
          legend = legend + "covering";
        }
        legend = legend + "}";
      }
      labels = labels.concat([
        {
          position: 0.8,
          attrs: {
            text: {
              text: legend,
              fill: '#0000ff'
            },
            rect: {
              fill: '#ffffff'
            }
          }
        }
      ]);
      link.set({
        labels: labels
      });
      return link;
    };

    ORMFactory.prototype.create_association_class = function(class_name, css_class) {
      if (css_class == null) {
        css_class = null;
      }
      return this.create_class(class_name, css_class);
    };

    return ORMFactory;

  })(model.Factory);

  exports.model.ORMFactory = ORMFactory;

}).call(this);
