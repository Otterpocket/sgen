#!/usr/bin/env ruby

$stderr.sync = true
require 'optparse'

#/ Usage: ruby sgen [options] [name]
#/ -c or --controller To gen Controller
#/ -p or --page To gen a Page class with a Page_Controller
#/ -m or --model To gen a DataObject
#/ -a or --admin To gen a ModelAdmin For given model
#/ -h or --help For this help text
#/ Example: ruby sgen --model Animal

def controller_template(n)
%{<?php

class #{n.capitalize}s_Controller extends Controller {

}
}
end

def page_template(n)
%{<?php

class #{n.capitalize}sPage extends Page {

}

class #{n.capitalize}sPage_Controller extends Page_Controller {

}
}
end

def model_template(n)
%{<?php

class #{n.capitalize} extends DataObject {

    private static $db = [];

}
}
end

def admin_template(n)
%{<?php

class #{n.capitalize}Admin extends ModelAdmin {

    private static $managed_models = [
        '#{n.capitalize}'
    ];

    private static $url_segment = '#{n.downcase}s';

    private static $menu_title = '#{n.capitalize}s';
}
}
end

file = __FILE__
ARGV.options do |opts|
  opts.on('-c name', '--controller name') do |name|
    File.open("app/controllers/#{name.capitalize}s.php", 'w') do |f|
        f.write(controller_template(name))
    end
  end

  opts.on('-p name', '--page name')  do |name|
    File.open("app/pages/#{name.capitalize}sPage.php", 'w') do |f|
        f.write(page_template(name))
    end
  end

  opts.on('-m name', '--model name')  do |name|
    File.open("app/models/#{name.capitalize}.php", 'w') do |f|
        f.write(model_template(name))
    end
  end

  opts.on('-a name', '--admin name')  do |name|
    File.open("app/admin/#{name.capitalize}Admin.php", 'w') do |f|
        f.write(admin_template(name))
    end
  end

  opts.on_tail('-h', '--help') { exec "grep ^#/<'#{file}'|cut -c4-" }
  opts.parse!
end
