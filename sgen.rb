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

def controller_tpl(n)
%{<?php

class #{n.capitalize}s_Controller extends Controller {

}
}
end

def page_tpl(n)
%{<?php

class #{n}sPage extends Page {

}

class #{n}sPage_Controller extends Page_Controller {

}
}
end

def model_tpl(n)
%{<?php

class #{n} extends DataObject {

    private static $db = [];

}
}
end

def admin_tpl(n)
%{<?php

class #{n}Admin extends ModelAdmin {

    private static $managed_models = [
        '#{n}'
    ];

    private static $url_segment = '#{n.downcase}s';

    private static $menu_title = '#{n.capitalize}s';
}
}
end

file = __FILE__
ARGV.options do |opts|
  opts.on('-c name', '--controller name') do |name|
    File.open("app/controllers/#{name.capitalize}s.php", 'w') { |f| f.write(controller_tpl(name)) }
  end

  opts.on('-p name', '--page name')  do |name|
    File.open("app/pages/#{name.capitalize}sPage.php", 'w') { |f| f.write(page_tpl(name)) }
  end

  opts.on('-m name', '--model name')  do |name|
    File.open("app/models/#{name.capitalize}.php", 'w') { |f| f.write(model_tpl(name)) }
  end

  opts.on('-a name', '--admin name')  do |name|
    File.open("app/admin/#{name.capitalize}Admin.php", 'w') { |f| f.write(admin_tpl(name)) }
  end

  opts.on_tail('-h', '--help') { exec "grep ^#/<'#{file}'|cut -c4-" }
  opts.parse!
end
