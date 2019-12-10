from clips import Environment, Symbol
from generate_facts import *
import asyncio

def list_to_fact(fact):
	res = '('
	for idx, element in enumerate(fact):
		res += str(element)
		if(idx != len(fact)-1):
			res += ", "
	res += ')'
	return res

class Analysis:
	def __init__(self, clp_file_name):
		self.initialize_env(clp_file_name)

	def initialize_env(self, clp_file_name):
		self.environment = Environment()
		self.environment.load(clp_file_name)

	def load_image(self, file_name):
		self.facts = create_facts(file_name)
		for fact in self.facts:
			self.environment.assert_string(list_to_fact(fact))

	def hit_rules(self):
		pass

	def matched_facts(self):
		for fact in self.environment.facts():
			print(fact)

	def detection_results(self, source_image_result, detection_image_result):
		return source_image_result == detection_image_result

	def show_facts(self):
		for fact in self.facts:
			print(list_to_fact(fact))

	def show_rules(self):
		for rule in self.environment.rules():
			print(rule.name)

	def open_image(self, filename):
		load_image(filename)
		return cv2.imread(filename)

	def run(self):
		self.environment.run()
		for rule in self.environment.activations():
			print(rule)
		print("Wat")
		for fact in self.environment.facts():
			print(fact)
		print("Done")

if __name__ == '__main__':
	analysis = Analysis('shape-detector.clp')

	#"./img/segiempat_trapesium_ratakanan.jpg"
	file_name = input('Masukkan nama file\n')
	analysis.load_image(file_name)
	#for rule in environment.activations():
	#	print(rule)
	#analysis.show_facts()
	#analysis.show_rules()
	analysis.run()