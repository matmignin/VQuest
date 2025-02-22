#!/Users/matbook/.pyenv/versions/3.8.3/envs/VQenv/bin/python
import json, sys, os, re

# a_code = "product"
a_code = sys.argv[1]

try:
	clear_code = sys.argv[2]
except:
	clear_code = None

# pattern_product = re.compile(r'(?P<product>[abcdefghijklmn]\d{3}).(?P<batch>\b\d{3}-\d{4}).(?P<lot>\b\d{4}\w\d\w?|\bBulk\b|G\d{7}\w?\b|VC\d{6}[ABCDEFGH]?|V[A-Z]\d{5}[A-Z]\d?|\d{5}\[A-Z]{3}\d)?.*?(?:ct\#)(?P<coated>\d{3}-\d{4})?',re.IGNORECASE)
if a_code == "product":
	pattern = re.compile(r'(?P<product>[abcdefghijklmn]\d{3})',re.IGNORECASE)
if a_code == "batch":
	pattern = re.compile(r'(?<!ct#)(?P<batch>\d{3}-\d{4})',re.IGNORECASE)
if a_code == "lot":
	pattern = re.compile(r'(?P<lot>\b\d{4}\w\d\w?|\bBulk\b|G\d{7}\w?\b|VC\d{6}[ABCDEFGH]?|V[A-Z]\d{5}[A-Z]\d?|\d{5}\[A-Z]{3}\d)',re.IGNORECASE)
if a_code == "coated":
	pattern = re.compile(r'(?:ct\#)(?P<coated>\d{3}-\d{4})',re.IGNORECASE)
if a_code == "SampleGUID":
	pattern = re.compile(r'(?P<SampleGUID>(s|\$)202\d{5}-\d{3}|[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12})',re.IGNORECASE)

try:
	with open(os.path.expanduser('/Volumes/~mmignin/VQ_Helper/Code.txt'), 'r') as f:
		code = f.read()
		match = pattern.search(code)
	print(match.group(a_code))
except:
	print('')
	# print('')
# else:
	# print(match.group(a_code))
	# print(code)




















