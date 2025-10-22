# This file contains the core classes and their respective functions so as to simplify the main file

class Project:
	"""
	This class acts as the root node for a project and keeps a list of all the task objects that are part of it.

	Attributes:
	name (string): The name of the Project.
	description (string): project description.
	tasks ([Task]): the contained tasks
	"""


	def __init__(self, name = "New Project": str, descr = "A new quest!": str) -> None:
		self.name = name
		self.description = descr
		self.tasks = []
		self._progress = 0.0
		#self.budget = 0.0
		self.tags = []

	def next_steps(self, num_tasks = 3: int) -> list[Task]:
		# return up to num_tasks tasks in project without prerequisites.

	def calc_progress(self) -> int:
		# calculate overall progress of the project.



class Task(name ):


	def __init__(self, name = "next step"):
		self.name = name
		self.details = ""
		self.prereqs = []
		self.blocks = []
		#self.resources = []

	def __str__(self):
		"""
		converts task to a string representation
		"""
		print(self.name + "\n" + self.details)


