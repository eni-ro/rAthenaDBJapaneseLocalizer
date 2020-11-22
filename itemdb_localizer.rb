# -*- encoding: utf-8 -*-
require 'gtk3'
require 'yaml'

builder = Gtk::Builder.new(file: 'ui.glade')

$win = builder.get_object('win')
btn_rathena = builder.get_object('btn_rathena')
btn_auriga = builder.get_object('btn_auriga')
btn_apply = builder.get_object('btn_apply')
$entry_rathena = builder.get_object('entry_rathena')
$entry_auriga = builder.get_object('entry_auriga')

$rathena_path = ""
$auriga_path = ""

def on_win_destroy
  Gtk.main_quit
end

def on_btn_rathena_clicked
	dialog = Gtk::FileChooserDialog.new(
		"Open File",
		$win,
		Gtk::FileChooserAction::OPEN,
		nil,
		#[Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL],
		[Gtk::Stock::OPEN, Gtk::ResponseType::ACCEPT])

	if dialog.run == Gtk::ResponseType::ACCEPT
		$rathena_path = dialog.filename
		$entry_rathena.set_text dialog.filename
	end
	dialog.destroy
end

def on_btn_auriga_clicked
	dialog = Gtk::FileChooserDialog.new(
		"Open File",
		$win,
		Gtk::FileChooserAction::OPEN,
		nil,
		#[Gtk::Stock::CANCEL, Gtk::ResponseType::CANCEL],
		[Gtk::Stock::OPEN, Gtk::ResponseType::ACCEPT])

	if dialog.run == Gtk::ResponseType::ACCEPT
		$auriga_path = dialog.filename
		$entry_auriga.set_text dialog.filename
	end
	dialog.destroy
end

def on_btn_apply_clicked
	if !File.exist?( $auriga_path ) || !File.exist?( $rathena_path )
		md = Gtk::MessageDialog.new(:parent => nil, :type => :info, :buttons_type => :close, :message => "File not found")
		md.signal_connect("response") do |widget, response|
			md.destroy
		end
		md.show_all
		return
	end
	db={}
	re = Regexp.new('^(//)?(\d+),[^,]*,([^,]*)')
	File.open($auriga_path, mode = "rt", encoding: 'cp932'){|f|
		f.each_line{|line|
			if m = re.match(line)
				db[m[2]]=m[3]
			end
		}
	}
	#元のコメント等の書式を維持するため、YAML形式の読み込みはせずに1行ずつ処理する
	File.rename($rathena_path, $rathena_path+'.bak')
	File.open($rathena_path, mode = "w", encoding: 'cp932') do |out_f|
		File.open($rathena_path+'.bak', mode = "rt", encoding: 'cp932'){|f|
			id = -1
			idre = Regexp.new('Id:\s*(\d+)')
			namere = Regexp.new('^(\s+Name:\s*).*')
			f.each_line{|line|
				if m = idre.match(line)
					id = m[1]
				elsif m = namere.match(line)
					if db.has_key?(id)
						line = m[1] + '\''+ db[id] + '\''	#マルチバイト文字で読み込みエラーにならないようにシングルクォーテーションを付ける
					end
				end
				out_f.puts line
			}
		}
	end
	md = Gtk::MessageDialog.new(:parent => nil, :flags => :destroy_with_parent,
		:type => :info, :buttons_type => :close, 
		:message => "Successfully applied")
	md.signal_connect("response") do |widget, response|
		md.destroy
		#複数ファイルを置換するのでメインは閉じない
	end
	md.show_all
end

builder.connect_signals { |handler| method(handler) } # handler は String

$win.show_all
Gtk.main
