
import bs4
import requests
from bs4 import BeautifulSoup as soup

my_url = 'https://www.spotrac.com/mlb/boston-red-sox/payroll/2016/'


filename = "salary_raw.csv"
f = open(filename, "w")
headers = "Year, Team, Name, Position, VetStatus, Salary, SalaryPerc \n"
f.write(headers)
x = ['atlanta-braves',
'miami-marlins','new-york-mets','philadelphia-phillies','washington-nationals','chicago-cubs','cincinnati-reds','milwaukee-brewers','pittsburgh-pirates',
'st.-louis-cardinals','arizona-diamondbacks','colorado-rockies','los-angeles-dodgers','san-diego-padres','san-francisco-giants','baltimore-orioles','boston-red-sox','new-york-yankees','tampa-bay-rays','toronto-blue-jays',
'chicago-white-sox','cleveland-indians','detroit-tigers','kansas-city-royals','minnesota-twins','houston-astros','los-angeles-angels','oakland-athletics','seattle-mariners','texas-rangers']
for t in x:
	for y in range(2009, 2020):
		my_url_pages = 'https://www.spotrac.com/' \
					'mlb/{}/payroll/{}/'.format(t, y)
		# Opening connection
		uClient = requests.get(my_url_pages)
		# Place content into variable
		page_html = uClient.text
		# Close connection
		uClient.close()
		# HTML parsing
		page_soup = soup(page_html, "html.parser")

		# Grab each player
		team = page_soup.findAll("div", {"class": "teams"})
		players = team[0].table.tbody.findAll("tr")

		for p in players:
			year = str(y)
			team_name = t
			position = p.find("td", {"class":"center small"}).text
			vet_stat = p.findAll("td", {"class" : "center small xs-hide"})[1].text
			player_name = p.find("td", {"class":"player"}).a.text
			salary = p.find("td", {"class":"result right"}).text
			salary_perc = p.findAll("td", {"class":"center"})[3].text
			f.write(year + "," + team_name + "," + player_name + "," + position + "," + vet_stat + "," + salary.replace(",", "") + "," + salary_perc + "\n")

f.close()




