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

    def getNomadScoreBar(self, element):
        value = element.find("ndiv").get('style')
        matches = re.search("([0-9.]+)", value)
        return matches.group(0)

    def getBackgroundImage(self, element):
        value = element.find("ndiv[@class='bg']")
        return value.get('data-bg')

    def getScores(self, element):
        values = element.find("ndiv[@class='action']")
        index = 0
        output = []

        for recordValue in values.findall("ndiv"):
            classValue = recordValue.get("class")
            matches = re.search("([0-9]{1})", classValue)

            if not matches is None:
                output.append(matches.group(0))

        return output

    def getName(self, element):
        value = element.find("ndiv[@class='text']").find("h2")
        value2 = value.find("a")

        if value2 is None:
            return "none"
        else:
            return value2.text

    def getSubName(self, element):
        value = element.find("ndiv[@class='text']").find("h3")

        if value is None:
            return "none"

        value2 = value.find("a")

        if value2 is None:
            return "none"
        else:
            return value2.text

    def getTemperature(self, element):
        values = element.find("ndiv[@class='attributes']")
        output = []

        if values is None:
            return "none"

        values = values.find("ndiv")

        if values is None:
            return "none"

        values = values.find("span[@class='temperature']")

        if values is None:
            return "none"

        tempC = values.find("span[@class='value unit metric']")

        if tempC is None:
            return "none"

        matchesC = re.search("([0-9.]+)", tempC.text)

        if not matchesC is None:
            output.append(matchesC.group(0))

        tempF = values.find("span[@class='value unit imperial']")

        if tempF is None:
            return "none"

        matchesF = re.search("([0-9.]+)", tempF.text)

        if not matchesF is None:
            output.append(matchesF.group(0))

        return output

    def getRank(self, element):
        values = element.find("ndiv[@class='attributes']")
        values = values.find("ndiv[@class='top-left']")
        output = []

        if values is None:
            return "none"

        values = values.find("ndiv")

        if values is None:
            return "none"

        return values.text

    def getCost(self, element):
        values = element.find("ndiv[@class='attributes']")
        values = values.find("ndiv[@data-value]")
        output = []

        if values is None:
            return "none"

        values = values.find("span[@class='value']")

        if values is None:
            return "none"

        return values.text

    def getInternetSpeed(self, element):
        values = element.find("ndiv[@class='attributes']")
        values = values.find("ndiv[@class='top-right']")
        output = []

        if values is None:
            return "none"

        values = values.find("span[@class='right']")

        if values is None:
            return "none"

        valuesValue = values.find("span[@class='value']")

        if valuesValue is None:
            return "none"

        output.append(valuesValue.text)
        mbpsValue = values.find("span[@class='mbps']")

        if mbpsValue is None:
            print("mbpsValue: " + values.text)
            return "none"

        output.append(mbpsValue.text)

        return output

    def readFirst(self):
        for recordItem in self.root_element.findall("ndiv[@data-item-type='record']"):
            dataId = recordItem.get('data-i')
            dataSlug = recordItem.get('data-slug')
            nomadScoreBar = self.getNomadScoreBar(recordItem.find("ndiv[@class='nomad_score_bar']"))

            record1 = recordItem.find("ndiv[@class='container']")
            record2 = recordItem.find("ndiv[@class='container lazyloaded']")
            selectedRecord = None

            backgroundImage = "none"
            scores = "none"
            name = "none"
            subName = "none"

            if not record1 is None:
                selectedRecord = record1

            if not record2 is None:
                selectedRecord = record2

            backgroundImage = self.getBackgroundImage(selectedRecord)
            scores = self.getScores(selectedRecord)
            scores_nomad_score = scores[0]
            scores_cost = scores[1]
            scores_internet = scores[2]
            scores_fun = scores[3]
            scores_safety = scores[4]

            name = self.getName(selectedRecord)
            subName = self.getSubName(selectedRecord)

            temperature = self.getTemperature(selectedRecord)
            temp_c = temperature[0]
            temp_f = temperature[1]

            rank = self.getRank(selectedRecord)
            cost = self.getCost(selectedRecord)

            internetSpeed = self.getInternetSpeed(selectedRecord)
            ispeed = internetSpeed[0]
            iunit = internetSpeed[1]

            print(dataId + "|" + dataSlug + "|" + nomadScoreBar + "|" + backgroundImage
            + "|" + scores_nomad_score + "|" + scores_cost + "|" + scores_internet + "|" + scores_fun + "|" + scores_safety
            + "|" + name + "|" + subName + "|" + temp_c + "|" + temp_f + "|" + rank + "|" + cost + "|" + ispeed + "|" + iunit)

if __name__ == '__main__':
    loader = DataLoader('./data.xml')
    loader.loadFile()
    loader.readFirst()
