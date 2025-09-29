#!/usr/bin/env python3

import requests
import datetime
import json
from collections import OrderedDict
import os
from dotenv import load_dotenv
import sys
import time

load_dotenv()

RETRY_DELAY = 2

MAX_RETRIES = 5
RETRY_DELAY = 3  # seconds

output = {}
success = False


GITHUB_USERNAME = os.getenv("GITHUB_USERNAME")
GITHUB_PAT = os.getenv("GITHUB_PAT")

if not GITHUB_USERNAME or not GITHUB_PAT:
    raise ValueError("GITHUB_USERNAME or GITHUB_PAT not set in .env")


today = datetime.date.today()
start_of_week = today - datetime.timedelta(days=(today.weekday() + 1) % 7)
from_date = start_of_week.isoformat() + "T00:00:00Z"
to_date = today.isoformat() + "T23:59:59Z"

query = """
query($user: String!, $from: DateTime!, $to: DateTime!) {
  user(login: $user) {
    contributionsCollection(from: $from, to: $to) {
      contributionCalendar {
        weeks {
          contributionDays {
            date
            contributionCount
            weekday
          }
        }
      }
    }
  }
}
"""

variables = {
    "user": GITHUB_USERNAME,
    "from": from_date,
    "to": to_date
}

headers = {
    "Authorization": f"Bearer {GITHUB_PAT}",
    "Accept": "application/vnd.github.v4.idl"
}

COLOR_SCHEME_DARK = {
    0: "#202329",   # No contributions
    1: "#0e4429",   # 1-3 commits
    2: "#006d32",   # 4-6 commits
    3: "#26a641",   # 7-9 commits
    4: "#39d353"    # 10+ commits
}

COLOR_SCHEME_LIGHT = {
    0: "#ebedf0",   # No contributions
    1: "#9be9a8",   # 1-3 commits
    2: "#40c463",   # 4-6 commits
    3: "#30a14e",   # 7-9 commits
    4: "#216e39"    # 10+ commits
}


theme = sys.argv[1].upper() if len(sys.argv) > 1 else "DARK"
if theme not in ["DARK", "LIGHT"]:
    print(f"Unknown theme '{theme}', defaulting to DARK.")
    theme = "DARK"

def get_color(count, theme):
    """Return heatmap color based on commit count and theme."""
    scheme = COLOR_SCHEME_DARK if theme == "DARK" else COLOR_SCHEME_LIGHT

    if count == 0:
        return scheme[0]
    elif 1 <= count <= 3:
        return scheme[1]
    elif 4 <= count <= 6:
        return scheme[2]
    elif 7 <= count <= 9:
        return scheme[3]
    else:
        return scheme[4]

def get_weekday_name(weekday):
    return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][(weekday + 1) % 7]


for attempt in range(MAX_RETRIES):
    try:
        if attempt > 0:
            time.sleep(RETRY_DELAY)

        response = requests.post(
            "https://api.github.com/graphql",
            json={"query": query, "variables": variables},
            headers=headers,
            timeout=10
        )
        response.raise_for_status()
        data = response.json()

        weeks = data["data"]["user"]["contributionsCollection"]["contributionCalendar"]["weeks"]

        contributions = OrderedDict()
        for i in range(7):
            day = start_of_week + datetime.timedelta(days=i)
            contributions[day] = 0

        for week in weeks:
            for day in week["contributionDays"]:
                date = datetime.date.fromisoformat(day["date"])
                if start_of_week <= date <= today:
                    contributions[date] = day["contributionCount"]

        dots = []
        tooltip_lines = []
        total_contributions = 0

        for date, count in contributions.items():
            color = get_color(count, theme)
            dots.append(f'<span foreground="{color}">■</span>')
            weekday = get_weekday_name(date.weekday())
            tooltip_lines.append(f"{weekday} ({date.day}/{date.month}): {count} contribution{'s' if count != 1 else ''}")
            total_contributions += count

        output = {
            "text": " ".join(dots),
            "tooltip": "\n".join([
                f"GitHub Contributions ({start_of_week.strftime('%d/%m')} to {today.strftime('%d/%m')})",
                f"Total: {total_contributions}"
            ] + tooltip_lines),
            "class": "github-contributions",
            "alt": "GitHub Contributions"
        }

        success = True
        break  # exit retry loop on success

    except requests.exceptions.RequestException as e:
        if attempt == MAX_RETRIES - 1:
            output = {
                "text": "⚠",
                "tooltip": f"GitHub API error: {str(e)}",
                "class": "error",
                "alt": "GitHub Error"
            }

    except Exception as e:
        output = {
            "text": "⚠",
            "tooltip": f"Error: {str(e)}",
            "class": "error",
            "alt": "Error"
        }
        break  # break if it's not a retryable error


print(json.dumps(output))
