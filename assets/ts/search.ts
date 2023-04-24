const options = {
  threshold: .4,
  location: 0,
  distance: 100,
  useExtendedSearch: true,
  shouldSort: true,
  includeScore: true,
  includeMatches: true,
  keys: [
    { name: "title", weight: .8 },
    { name: "linkTitle", weight: .8 },
    { name: "contents", weight: .5 },
    { name: "tags", weight: .3 },
    { name: "categories", weight: .3 },
  ],
};

// const result_template = `<article id="result-${key}">
// <h4><a href="${url}">${title}</a></h4>
// <p>${snippet}</p>
// ${ isset tags }<p>Tags: ${tags}</p>${ end }
// ${ isset categories }<p>Categories: ${categories}</p>${ end }
// </article>
// `;

function param(name: string): string | null {
  return (new URLSearchParams(window.location.search)).get(name);
}

function search(): void {
  fetch('/index.json').then(r => r.json()).then(function(pages) {
    const query = (new URLSearchParams(window.location.search)).get('q');
    const results = document.getElementById('search-results');
    const fuse = new Fuse(pages, options);
    fuse.search(query).forEach((result, index: number) => {
      console.log(index, result);
      const article = document.createElement('article');
      article.id = `result-${index}`;
      const header = document.createElement('h4');
      const link = document.createElement('a');
      link.setAttribute('href', result.item.url);
      link.innerText = result.item.linkTitle;
      header.appendChild(link);
      article.appendChild(header);
      let snippet = '';
      const highlights = [];
      result.matches.forEach((match, index) => {
        if (match.key == 'tags' || match.key == 'categories') {
          highlights.push(match.value);
        } else if (match.key == 'contents') {
          const start = match.indices[0][0];
          const end = match.indices[0][1] - match.indices[0][0] + 1;
          snippet += result.item.contents.substring(start, end);
          highlights.push(match.value.substring(match.indices[0][0], match.indices[0][1] - match.indices[0][0] + 1));
        }
      });
      const p = document.createElement('p');
      p.innerText = snippet;
      article.appendChild(p);
      results.appendChild(article);
    });
  });
}

document.addEventListener('DOMContentLoaded', search);
