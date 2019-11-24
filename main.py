from clips import Environment, Symbol
from generate_facts import *

def hit_rules():
	pass

def matched_facts():
	pass

def detection_results(source_image_result, detection_image_result):
	return source_image_result == detection_image_result

def show_facts():
	pass

def show_rules():
	pass

def open_image(filename):
	return cv2.imread(filename)

if __name__ == '__main__':
	environment = Environment()

	# load constructs into the environment
	environment.load('shape-detector.clp')

	#"./img/segiempat_trapesium_ratakanan.jpg"
	file_name = input('Masukkan nama file')
	#facts = generate_facts(file_name)
	#facts = environment.assert_string('(start-it)')
	#for fact in facts:
	#	environment.assert_string(fact)

	environment.run()