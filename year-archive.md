---
title: "All Posts"
layout: archive
excerpt: ""
permalink: /year-archive/
author_profile: true
header:
  overlay_image: /assets/images/australia/darksand.jpg
  caption: "North Stradbroke Island, Queensland, Australia"
---

{% include base_path %}
{% capture written_year %}'None'{% endcapture %}
{% for post in site.posts %}
  {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
  {% if year != written_year %}
  <h2 id="{{ year | slugify }}" class="archive__subtitle">{{ year }}</h2>
    {% capture written_year %}{{ year }}{% endcapture %}
  {% endif %}
  {% include archive-single.html %}
{% endfor %}