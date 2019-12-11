from clips import Environment, Symbol
from generate_facts import *
import asyncio

def list_to_fact(fact):
	res = '('
	for idx, element in enumerate(fact):
		res += str(element)
		if(idx != len(fact)-1):
			res += " "
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

	def print_rule(self, iteration, rule):
		res = (' '*iteration + rule)
		res += '\n'
		self.done[rule] = True
		for rule in self.rule_list[rule]:
			if not(self.done[rule]):
				res += self.print_rule(iteration+1, rule)
		return res

	def hit_rules(self):
		self.done = dict.fromkeys(self.rule_list, False)
		res = ""
		for rule in self.rule_list:
			if not(self.done[rule]):
				res += self.print_rule(0, rule)
		print("Hit rules:")
		print(res)
		return res

	def matched_facts(self):
		res = ""
		for fact in self.environment.facts():
			print(fact)
			res += "f-" + str(fact.index) + " " + str(fact)
			res += '\n'
		print("Matched facts:")
		print(res)
		return res

	def detection_results(self, source_image_result):
		return "True dulu lah ya"

	def show_facts(self):
		res = ""
		for fact in self.facts:
			res += (list_to_fact(fact))
			res += "\n"
		print(res)
		return res

	def show_rules(self):
		res = ""
		for rule in self.environment.rules():
			res += rule.name
			res += "\n"
		print("Rule list:")
		print(res)

	def open_image(self, filename):
		load_image(filename)
		return cv2.imread(filename)

	def run(self):
		self.rule_list = dict.fromkeys([self.get_name(rule) for rule in self.environment.activations()], [])
		while(len([rule for rule in self.environment.activations()])):
			activations = self.environment.activations()
			current_rule = next(activations)
			rule_name = self.get_name(current_rule)
			self.environment.run(1)
			self.update_rule_matched(rule_name)

	def get_name(self, rule):
		return rule.name+' '+rule.__repr__().split(':')[2]

	def update_rule_matched(self, rule_name):
		if(not(rule_name in self.rule_list.keys())):
			self.rule_list[rule_name] = []
		for activation in self.environment.activations():
			if(not(self.get_name(activation) in self.rule_list.keys())):
				self.rule_list[self.get_name(activation)] = []
				self.rule_list[rule_name].append(self.get_name(activation))

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
	analysis.matched_facts()
	analysis.hit_rules()
	analysis.open_result_image()