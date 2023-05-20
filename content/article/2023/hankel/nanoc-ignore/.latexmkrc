#!/usr/bin/env perl

$latex = $lualatex;
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars';
$hash_calc_ignore_pattern{'luc'}='^';
$hash_calc_ignore_pattern{'lua'}='^';
$pdf_mode = 4;
