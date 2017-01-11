#!/usr/bin/env python3

import os, sys
import sched, time

import re
import threading
import logging
import logging.handlers

from datetime import datetime, timedelta
from time import gmtime, strftime

from lxml import etree
import xml.etree.ElementTree as ET

class DataLoader(object):

    def __init__(self, filename):
        self.filename = filename

    def loadFile(self):
        self.root_element = ET.parse(self.filename).getroot()

    def readHumidity(self):
        pattern = re.compile("<td>Humidity</td><td>[A-Za-z ]+\(([0-9]+)\%\)</td>")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Humidity: " + str(match.groups()))

    def readAirQuality(self):
        pattern = re.compile("Air quality</td><td><i class=\"fa fa-leaf\"></i>\&nbsp\;([A-Za-z]+)</td>")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Air quality: " + str(match.groups()))

    def readNomadCost(self):
        pattern = re.compile("NomadCost™</td><td>(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("NomadCost: " + str(match.groups()))

    def readExpatCostOfLiving(self):
        pattern = re.compile("Expat cost of living</td><td>(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Expat cost of living: " + str(match.groups()))

    def readLocalCostOfLiving(self):
        pattern = re.compile("Local cost of living</td><td>(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Local cost of living: " + str(match.groups()))

    def readOneBedroomApartment(self):
        pattern = re.compile("apartment \(center\)</td><td class=\"tooltip\" title=\"Click to modify\">(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("1 bedroom apartment (center): " + str(match.groups()))

    def readHotelRoom(self):
        pattern = re.compile("Hotel room</a></td><td class=\"tooltip\">(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Hotel room: " + str(match.groups()))

    def readAirbnbApartmentMonth(self):
        pattern = re.compile("Airbnb apartment</a></a></td><td>(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Airbnb apartment m: " + str(match.groups()))

    def readAirbnbApartmentDay(self):
        pattern = re.compile("Airbnb apartment</a></a></td><td>(\$[0-9., ]+/ d)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Airbnb apartment d: " + str(match.groups()))

    def readCoworkingSpace(self):
        pattern = re.compile("Coworking space</a></td><td>(\$[0-9., ]+/ m)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Coworking space: " + str(match.groups()))

    def readCocaColaInCafe(self):
        pattern = re.compile("Coca-Cola \(0.3L\) in cafe</td><td class=\"tooltip\" title=\"Click to modify\">(\$[0-9., ]+)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Coca-Cola (0.3L) in cafe: " + str(match.groups()))

    def readPintOfBeerInBar(self):
        pattern = re.compile("Pint of beer \(0.5L\) in bar</td><td class=\"tooltip\" title=\"Click to modify\">(\$[0-9., ]+)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Pint of beer (0.5L) in bar: " + str(match.groups()))

    def readCappucinoInCafe(self):
        pattern = re.compile("Cappucino in cafe</td><td class=\"tooltip\" title=\"Click to modify\">(\$[0-9., ]+)<div")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Cappucino in cafe: " + str(match.groups()))

    def readRegion(self):
        pattern = re.compile("<td>Region</td><td><a href=\"[/A-Za-z-_]+\" title=\"([A-Za-z]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Region: " + str(match.groups()))

    def readPopulation(self):
        pattern = re.compile("<td>Population</td><td>([0-9,.]+)</td>")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Population: " + str(match.groups()))

    def readReligious(self):
        pattern = re.compile("<td>Religious</td><td>([()a-zA-Z0-9 ]*)</td>")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Religious: " + str(match.groups()))

    def readGenderRatio(self):
        pattern = re.compile("<tr><td>Gender ratio \(F/M\)</td><td>([0-9.,]+) 💁 / ([0-9.,]+) 👨</td></tr>")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Gender ratio (F/M): " + str(match.groups()))

    def readPeace(self):
        pattern = re.compile("<td>Peace<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Peace: " + str(match.groups()))

    def readNightlife(self):
        pattern = re.compile("<td>Nightlife<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Nightlife: " + str(match.groups()))

    def readFreeWifiInCity(self):
        pattern = re.compile("<td>Free[ ]{1}WiFi[ ]{1}in[ ]{1}city<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Free Wifi in city: " + str(match.groups()))

    def readPlacesToWorkFrom(self):
        pattern = re.compile("<td>Places[ ]{1}to[ ]{1}work[ ]{1}from<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Places to work from: " + str(match.groups()))

    def readAcOrHeating(self):
        pattern = re.compile("<td>A/C[ ]{1}or[ ]{1}heating<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("AC or heating: " + str(match.groups()))

    def readFriendlyToForeigners(self):
        pattern = re.compile("<td>Friendly[ ]{1}to[ ]{1}foreigners<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Friendly to foreigners: " + str(match.groups()))

    def readFemaleFriendly(self):
        pattern = re.compile("<td>Female[ ]{1}friendly<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Female friendly: " + str(match.groups()))

    def readGayFriendly(self):
        pattern = re.compile("<td>Gay[ ]{1}friendly<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Gay friendly: " + str(match.groups()))

    def readEnglishSpeaking(self):
        pattern = re.compile("<td>English[ ]{1}speaking<div[ ]{1}class=\"description\"></div></td><td><span><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"[ ]{1}title=\"([0-9/ ]+)\"")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("English speaking: " + str(match.groups()))

    def readStartupScore(self):
        pattern = re.compile("<td>Startup[ ]{1}Score</td><td><div[ ]{1}class=\"[A-Za-z]+[ ]*r([0-9]+)\"><div class=\"[A-Za-z0-9-_ ]+\">([0-9.,/]+)</div>")

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Startup score: " + str(match.groups()))

    def readWorkPlaces(self):
        regexp_q = "<div[ ]{1}class=\"item[ ]{1}show-now[ ]{1}[A-Za-z0-9\.\,\:\_\-]+\"[ ]{1}data-url=\"([#\/\:\,\.\-\_ A-Za-z0-9]*)\"[ ]{1}data-slug=\"([#\/\:\,\.\-\_ A-Za-z0-9]*)\">"

        pattern = re.compile(regexp_q)
        output = []

        for i, line in enumerate(open(self.filename)):
            for match in re.finditer(pattern, line):
                print("Work place: " + str(match.groups()))
                output.append(match.group(1))

        self.loadFile()

        for item in output:
            for elementItem in self.root_element.findall("[@data-slug='" + str(item) + "']"):
                print("data-slug: " + elementItem.get('data-slug'))

if __name__ == '__main__':
    loader = DataLoader('./data.html')

    loader.readHumidity()
    loader.readAirQuality()
    loader.readNomadCost()
    loader.readExpatCostOfLiving()
    loader.readLocalCostOfLiving()
    loader.readOneBedroomApartment()
    loader.readHotelRoom()
    loader.readAirbnbApartmentMonth()
    loader.readAirbnbApartmentDay()
    loader.readCoworkingSpace()
    loader.readCocaColaInCafe()
    loader.readPintOfBeerInBar()
    loader.readCappucinoInCafe()
    loader.readRegion()
    loader.readPopulation()
    loader.readReligious()
    loader.readGenderRatio()
    loader.readPeace()
    loader.readNightlife()
    loader.readFreeWifiInCity()
    loader.readPlacesToWorkFrom()
    loader.readAcOrHeating()
    loader.readFriendlyToForeigners()
    loader.readFemaleFriendly()
    loader.readGayFriendly()
    loader.readEnglishSpeaking()
    loader.readStartupScore()
