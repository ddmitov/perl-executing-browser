#!/usr/bin/perl

##############################################################
#
# BG Volumina v. 0.3
# Bibliographic Database Script Kit.
# NO WARRANTIES OR SUPPORT OF ANY KIND -
# USE AT YOUR OWN RISK!
# This script is not copyrighted and
# is in the public domain!
# You can use it for any legal purpose!
# You can modify it and redistibute it by any means!
# Author: Dimitar D. Mitov ddmitov@yahoo.com
# You need Perl 5.8.3 or higher to run this Perl module!
# This Perl module is in Unicode (UTF-8) code page!
#
##############################################################

# SCRIPTS FILENAMES:
$add_script = 'vol-add.pl';
$edit_script = 'vol-edit.pl';
$delete_script = 'vol-del.pl';
$edit_form_script = 'vol-edit-form.pl';
$read_form_script = 'vol-read-form.pl';
$read_script = 'vol-read.pl';
$search_form_script = 'vol-search-form.pl';
$search_script = 'vol-search.pl';
$sort_script = 'vol-sort.pl';

# HTTP ADDRESS FOR DUMP FILES:
$http_dump ='http://localhost/db';

# DELIMITER:
$delimiter='\|';

# DATABASES SEQUENCE:
if ($ENV{'QUERY_STRING'} =~ 'db=cyr.txt'){$next_db='lat.txt'};
if ($ENV{'QUERY_STRING'} =~ 'db=lat.txt'){$next_db='cyr.txt'};

# LAST DATABASE:
$last_db='lat.txt';

# HTML STYLES AND COLOURS:
$read_only_css = "<style type=text/css>a:hover {color: #ff3830}</style>";
$read_only_body = "<body bgcolor='ffffff' text='000000' link='000000' vlink='000000' alink='000000'>";

$dialog_css = "<style type=text/css>a {text-decoration: none} a:hover {color: #ff3830}</style>";
$dialog_body = "<body bgcolor='#ffffb8' link='#a03830' vlink='#a03830' alink='#ff3830'>";

$edit_css = "<style type=text/css>a:hover {color: #ff3830}</style>";
$edit_body = "<body bgcolor='ffffff' text='000000' link='#0000ff' vlink='#0000ff' alink='#ff3830'>";

#HTML interface
#Common HTML interface
$label_bg_html_title = 'BG Volumina Example Database';
$label_bg_error_open = 'ГРЕШКА ПРИ ОТВАРЯНЕТО НА БАЗАТА ДАННИ!';
$label_bg_back = 'НАЗАД';
$label_bg_author = 'АВТОР';
$label_bg_alias = 'ALIAS';
$label_bg_title = 'ЗАГЛАВИЕ';
$label_bg_place = 'МЯСТО';
$label_bg_journal = 'ПОРЕДИЦА';
$label_bg_volume = 'ТОМ';
$label_bg_year = 'ГОДИНА';
$label_bg_pages = 'СТРАНИЦИ';
$label_bg_results = 'РЕЗУЛТАТИ';
$label_bg_file = 'ФАЙЛ';
$label_bg_records = 'ЗАПИСИ';
$label_bg_wrong_range = 'ГРЕШЕН ХРОНОЛОГИЧЕН ОБХВАТ!';
$label_bg_enter_four_digits = 'МОЛЯ ВЪВЕДЕТЕ ЧЕТИРИЦИФРЕНИ ЧИСЛА!';
$label_bg_page = 'СТРАНИЦА';
$label_bg_from = 'от';
$label_bg_result = 'РЕЗУЛТАТ';
$label_bg_confirm_delete = 'Желаете ли да изтриете записа?';
$label_bg_delete = 'ИЗТРИЙ';
$label_bg_confirm_edit = 'Желаете ли да редактирате записа?';
$label_bg_edit = 'РЕДАКТИРАЙ';
$label_bg_previous_page = 'ПРЕДИШНА СТРАНИЦА';
$label_bg_next_page = 'СЛЕДВАЩА СТРАНИЦА';
$label_bg_no_results = 'НЯМА РЕЗУЛТАТИ В ТАЗИ ЧАСТ НА БАЗАТА ДАННИ!';
$label_bg_current_db = 'НАСТОЯЩА ЧАСТ НА БАЗАТА ДАННИ:';
$label_bg_next_db = 'СЛЕДВАЩА ЧАСТ НА БАЗАТА ДАННИ:';
$label_bg_no_results_last_db = 'НЯМА РЕЗУЛТАТИ В ПОСЛЕДНАТА ЧАСТ НА БАЗАТА ДАННИ!';
$label_bg_wrong_results_per_page = 'НЕПРИЕМЛИВ БРОЙ РЕЗУЛТАТИ НА СТРАНИЦА!';
$label_bg_enter_positive_value = 'МОЛЯ ВЪВЕДЕТЕ ЕДИНИЦА ИЛИ ПО-ГОЛЯМО ЧИСЛО!';
$label_bg_add = 'ЗАПИШИ';
$label_bg_reset = 'ИЗТРИЙ';
$label_bg_results_per_page = 'РЕЗУЛТАТИ НА СТРАНИЦА';
$label_bg_up = 'увеличи';
$label_bg_down = 'намали';
$label_bg_range = 'ХРОНОЛОГИЧЕН ОБХВАТ';
$label_bg_first_year = 'НАЧАЛНА ГОДИНА';
$label_bg_last_year = 'КРАЙНА ГОДИНА';
$label_bg_sort_criteria = 'КРИТЕРИИ ЗА СОРТИРАНЕ';
$label_bg_edit_off = 'Редактиране на записите - изключено';
$label_bg_edit_on = 'Редактиране на записите - включено';
$label_bg_help = 'Помощ';
$label_bg_off = 'изключен';
$label_bg_start_form = 'Започни';
$label_bg_start = '&nbsp &nbsp НАЧАЛО';
$label_bg_end = '&nbsp &nbsp КРАЙ';
$label_bg_no_request = 'НЯМА ЗАЯВКА!';
$label_bg_wrong_request = 'ГРЕШНА ЗАЯВКА!';
$label_bg_success = 'ФАЙЛЪТ Е ЗАПИСАН!';
$label_bg_open = 'ПРОЧЕТИ РЕЗУЛТАТИТЕ';
$label_bg_end_dump = 'КРАЙ';
$label_bg_no_results = 'НЯМА РЕЗУЛТАТИ!';

$label_bg_cyr_titles = 'Заглавия на кирилица';
$label_bg_lat_titles = 'Заглавия на латиница';

$label_en_html_title = 'BG Volumina Example Database';
$label_en_error_open = 'ERROR OPENING DATABASE!';
$label_en_back = 'BACK';
$label_en_author = 'AUTHOR';
$label_en_alias = 'ALIAS';
$label_en_title = 'TITLE';
$label_en_place = 'PLACE';
$label_en_journal = 'JOURNAL';
$label_en_volume = 'VOLUME';
$label_en_year = 'YEAR';
$label_en_pages = 'PAGES';
$label_en_results = 'RESULTS';
$label_en_file = 'FILE';
$label_en_records = 'RECORDS';
$label_en_wrong_range = 'WRONG RANGE!';
$label_en_enter_four_digits = 'PLEASE ENTER FOUR DIGIT NUMBERS!';
$label_en_page = 'PAGE';
$label_en_from = 'from';
$label_en_result = 'RESULT';
$label_en_confirm_delete = 'Are you sure you want to delete this record?';
$label_en_delete = 'DELETE';
$label_en_confirm_edit = 'Are you sure you want to edit this record?';
$label_en_edit = 'EDIT';
$label_en_previous_page = 'PREVIOUS PAGE';
$label_en_next_page = 'NEXT PAGE';
$label_en_no_results = 'NO RESULTS IN THIS PART OF THE DATABASE!';
$label_en_current_db = 'CURRENT PART OF THE DATABASE:';
$label_en_next_db = 'NEXT PART OF THE DATABASE:';
$label_en_no_results_last_db = 'NO RESULTS IN THE LAST PART OF THE DATABASE!';
$label_en_wrong_results_per_page = 'UNACCEPTABLE RESULTS PER PAGE VALUE!';
$label_en_enter_positive_value = 'PLEASE ENTER ONE OR GREATER NUMBER!';
$label_en_add = '  ADD  ';
$label_en_reset = 'RESET';
$label_en_results_per_page = 'RESULTS PER PAGE';
$label_en_up = 'increase';
$label_en_down = 'decrease';
$label_en_range = 'TIME RANGE';
$label_en_first_year = 'FIRST YEAR';
$label_en_last_year = 'LAST YEAR';
$label_en_sort_criteria = 'SORT CRITERIA';
$label_en_edit_off = 'Editing records - off';
$label_en_edit_on = 'Editing records - on';
$label_en_help = 'Help';
$label_en_off = 'off';
$label_en_start_form = 'Start';
$label_en_start = '&nbsp &nbsp START';
$label_en_end = '&nbsp &nbsp END';
$label_en_no_request = 'NO REQUEST!';
$label_en_wrong_request = 'WRONG REQUEST!';
$label_en_success = 'FILE SAVED!';
$label_en_open = 'READ RESULTS';
$label_en_end_dump = 'END';
$label_en_no_results = 'NO RESULTS!';

$label_en_cyr_titles = 'Cyrillic titles';
$label_en_lat_titles = 'Latin titles';

#vol-add.pl
$label_bg_added = 'ЗАПИСЪТ Е ДОБАВЕН!';

$label_en_added = 'RECORD ADDED!';

#vol-add-form.pl
$label_bg_add_form_title = 'ДОБАВЯНЕ НА НОВИ ЗАПИСИ';

$label_en_add_form_title = 'ADDING NEW RECORDS';

#vol-del.pl
$label_bg_deleted = 'ЗАПИСЪТ Е ИЗТРИТ!';

$label_en_deleted = 'RECORD DELETED!';

#vol-dump.pl
$label_bg_dump_request = 'ЗАЯВКА ЗА ЗАПИС ВЪВ ФАЙЛ';
$label_bg_results_big = 'РЕЗУЛТАТИ ОТ ЗАПИСА ВЪВ ФАЙЛ';

$label_en_dump_request = 'DUMP REQUEST';
$label_en_results_big = 'DUMP RESULTS';

#vol-edit.pl
$label_bg_changes_saved = 'ПРОМЕНИТЕ СА ЗАПИСАНИ!';

$label_en_changes_saved = 'CHANGES SAVED!';

#vol-edit-form.pl
$label_bg_edit_form_title = 'РЕДАКТОР НА ЗАПИСИ';

$label_en_edit_form_title = 'RECORD EDITOR';

#vol-read.pl
$label_bg_read_request = 'ЗАЯВКА ЗА ОБЩ ПРЕГЛЕД НА ЗАГЛАВИЯТА';
$label_bg_read_results = 'РЕЗУЛТАТИ ОТ ОБЩИЯ ПРЕГЛЕД НА ЗАГЛАВИЯТА';
$label_bg_browse = 'ПРЕГЛЕД';
$label_bg_browse_in_next_db = 'ОБЩ ПРЕГЛЕД СЪС СЪЩАТА ЗАЯВКА В СЛЕДВАЩАТА ЧАСТ НА БАЗАТА ДАННИ';
$label_bg_browse_in_first_db = 'ОБЩ ПРЕГЛЕД СЪС СЪЩАТА ЗАЯВКА В ПЪРВАТА ЧАСТ НА БАЗАТА ДАННИ';
$label_bg_wrong_start_page = 'НЕПРИЕМЛИВО ЧИСЛО ЗА НАЧАЛНА СТРАНИЦА!';

$label_en_read_request = 'TITLES BROWSE REQUEST';
$label_en_read_results = 'TITLES BROWSE RESULTS';
$label_en_browse = 'BROWSE';
$label_en_browse_in_next_db = 'BROWSE WITH THE SAME REQUEST IN THE NEXT PART OF THE DATABASE';
$label_en_browse_in_first_db = 'BROWSE WITH THE SAME REQUEST IN THE FIRST PART OF THE DATABASE';
$label_en_wrong_start_page = 'UNACCEPTABLE NUMBER FOR START PAGE!';

#vol-read-form.pl
$label_bg_read_form_title = 'ОБЩ ПРЕГЛЕД НА ЗАПИСИТЕ';
$label_bg_start_page = 'ЗАПОЧНИ ОТ СТРАНИЦА';

$label_en_read_form_title = 'BROWSING RECORDS';
$label_en_start_page = 'START FROM PAGE';

#vol-search.pl
$label_bg_search_request = 'ЗАЯВКА ЗА ТЪРСЕНЕ В ЗАГЛАВИЯТА';
$label_bg_results_big = 'РЕЗУЛТАТИ ОТ ТЪРСЕНЕТО В ЗАГЛАВИЯТА';
$label_bg_search = 'ТЪРСЕНЕ';
$label_bg_search_in_next_db = 'ТЪРСЕНЕ СЪС СЪЩАТА ЗАЯВКА В СЛЕДВАЩАТА ЧАСТ НА БАЗАТА ДАННИ';
$label_bg_search_in_first_db = 'ТЪРСЕНЕ СЪС СЪЩАТА ЗАЯВКА В ПЪРВАТА ЧАСТ НА БАЗАТА ДАННИ';

$label_en_search_request = 'TITLES SEARCH REQUEST';
$label_en_results_big = 'TITLES SEARCH RESULTS';
$label_en_search = 'SEARCH';
$label_en_search_in_next_db = 'SEARCH WITH THE SAME REQUEST IN THE NEXT PART OF THE DATABASE';
$label_en_search_in_first_db = 'SEARCH WITH THE SAME REQUEST IN THE FIRST PART OF THE DATABASE';

#vol-search-form.pl
$label_bg_title_main = 'ТЪРСЕНЕ В ЗАГЛАВИЯТА';
$label_bg_case_off = 'Без отчитане на главни и малки букви';
$label_bg_case_on = 'С отчитане на главни и малки букви';
$label_bg_search_form = 'Търси';

$label_en_title_main = 'TITLES SEARCH FORM';
$label_en_case_off = 'Case sensitivity searching - disabled';
$label_en_case_on = 'Case sensitivity searching - enabled';
$label_en_search_form = 'Search';

#vol-sort.pl
$label_bg_sorted = 'ФАЙЛЪТ Е СОРТИРАН!';

$label_en_sorted = 'FILE SORTED!';

#vol-sort-form.pl
$label_bg_sort_form_title = 'ТРАЙНО СОРТИРАНЕ НА ЗАПИСИ';

$label_en_sort_form_title = 'PERMANENTLY SORTING DATABASE RECORDS';

# Help files:
$help_bg = '../help_bg.htm';

$help_en = '../help_en.htm';

sub form_css{
print "<style type=text/css>a {text-decoration: none} a:hover {color: #ff3830}</style>\n";
}

sub aceTextField{
print "<!-- Style Sheet Code by: WWW.CGISCRIPT.NET, LLC -->\n";
print "<style type='text/css'><!--\n";
print ".aceTextField {\n";
print "background-color: white;\n";
print "border-width: 1;\n";
print "color: black;\n";
print "font-family: verdana;\n";
print "font-size: 10pt;\n";
print "font-weight: bold;\n";
print "}\n";
print "--></style>\n";
}

sub aceTextArrea{
print "<!-- FREE code from WWW.CGISCRIPT.NET, LLC -->\n";
print "<style type='text/css'><!--\n";
print ".aceTextArrea {\n";
print "background-color: white;\n";
print "border-width: 1;\n";
print "color: black;\n";
print "font-family: verdana;\n";
print "font-size: 10pt;\n";
print "font-weight: bold;\n";
print "}\n";
print "--></style>\n";
}

sub aceButton{
print "<!-- CSS Code by: WWW.CGISCRIPT.NET, LLC -->\n";
print "<style type='text/css'><!--\n";
print ".aceButton {\n";
print "background-color: #efefef;\n";
print "border-color: #dfdfdf;\n";
print "border-style: solid;\n";
print "border-width: 2;\n";
print "color: #000000;\n";
print "font-family: verdana;\n";
print "font-size: 10pt;\n";
print "font-weight: bold;\n";
print "}\n";
print "--></style>\n";
}

sub brownButton{
print "<style type=text/css>\n";
print "DIV.menu {\n";
print "padding-right: 5px;\n";
print "padding-left: 5px;\n";
print "padding-bottom: 5px;\n";
print "width: 100%;\n";
print "padding-top: 5px;\n";
print "}\n";

print "A.menu {\n";
print "border-right: #f5d996 outset;\n";
print "padding-right: 3px;\n";
print "border-top: #f5d996 outset;\n";
print "padding-left: 3px;\n";
print "font-weight: bold;\n";
print "font-size: 9pt;\n";
print "padding-bottom: 3px;\n";
print "border-left: #f5d996 outset;\n";
print "width: 100px;\n";
print "color: #000000;\n";
print "padding-top: 3px;\n";
print "border-bottom: #f5d996 outset;\n";
print "font-style: normal;\n";
print "font-family: verdana;\n";
print "background-color: #f5d996;\n";
print "text-align: center;\n";
print "}\n";

print "A.menu:hover {\n";
print "border-right: #f5d996 inset;\n";
print "border-top: #f5d996 inset;\n";
print "border-left: #f5d996 inset;\n";
print "color: #ffffff;\n";
print "border-bottom: #f5d996 inset;\n";
print "background-color: #8c1f13;\n";
print "}\n";
print "</style>\n";
}

sub field_focus{
print "<SCRIPT LANGUAGE='JavaScript'>\n";

print "<!-- This script and many more are available free online at -->\n";
print "<!-- The JavaScript Source!! http://javascript.internet.com -->\n";
print "<!-- John Munn  (jrmunn\@home.com) -->\n";

print "<!-- Begin\n";
print "function putFocus(formInst, elementInst) {\n";
print "if (document.forms.length > 0) {\n";
print "document.forms[formInst].elements[elementInst].focus();\n";
print "}\n";
print "}\n";
print "// The second number in the \"onLoad\" command in the body\n";
print "// tag determines the form's focus. Counting starts with '0'\n";
print "// End -->\n";
print "</script>\n";
}

