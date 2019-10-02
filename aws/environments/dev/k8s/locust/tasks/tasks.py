from locust import HttpLocust, TaskSet, task

class ElbTasks(TaskSet):
  @task
  def getlatestblock(self):
      self.client.post(url = "/api/v3/", json = {"jsonrpc": "2.0","method": "icx_getLastBlock","id": 1234})

class ElbWarmer(HttpLocust):
  task_set = ElbTasks
  min_wait = 500
  max_wait = 2000