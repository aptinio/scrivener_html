defmodule Scrivener.HTML.SEOTest do
  use ExUnit.Case
  import Scrivener.HTML.SEO
  alias Scrivener.Page
  doctest Scrivener.HTML.SEO

  describe "#rel" do
    test "on the first page - page 2" do
      assert rel(%Page{total_pages: 10, page_number: 1}, 2) == "next"
    end

    test "on the first page - page 5" do
      assert rel(%Page{total_pages: 10, page_number: 1}, 5) == "canonical"
    end

    test "on the third page - page 4" do
      assert rel(%Page{total_pages: 10, page_number: 3}, 4) == "next"
    end

    test "on the third page - page 2" do
      assert rel(%Page{total_pages: 10, page_number: 3}, 2) == "prev"
    end

    test "on the last page - page 9" do
      assert rel(%Page{total_pages: 10, page_number: 10}, 9) == "prev"
    end
  end

  describe "#header_links" do
    test "on the first page" do
      assert %Page{total_pages: 10, page_number: 1}
             |> header_links()
             |> Phoenix.HTML.safe_to_string() ==
               "<link href=\"?page=2\" rel=\"next\"></link>"
    end

    test "on the last page" do
      assert %Page{total_pages: 10, page_number: 10}
             |> header_links()
             |> Phoenix.HTML.safe_to_string() ==
               "<link href=\"?page=9\" rel=\"prev\"></link>"
    end

    test "on a middle page" do
      assert %Page{total_pages: 10, page_number: 5}
             |> header_links()
             |> Phoenix.HTML.safe_to_string() ==
               "<link href=\"?page=4\" rel=\"prev\"></link>\n<link href=\"?page=6\" rel=\"next\"></link>"
    end
  end
end
