
class Personnel:

	def __init__(self, name: str = "Personnel Name", title: str = "Employee") -> None:
		self.name = name
		self.title = title
		self.skills = {} # Dictionary

if __name__ == "__main__":
	print("you have chosen personnel!")
